module MachineShop
  module Util
    def self.objects_to_ids(h)
      case h
      when APIResource
        h.id
      when Hash
        res = {}
        h.each { |k, v| res[k] = objects_to_ids(v) unless v.nil? }
        res
      when Array
        h.map { |v| objects_to_ids(v) }
      else
        h
      end
    end

    def self.convert_to_machineshop_object(resp, auth_token, type=nil)
      types = {
        'Device' => Device,
        'DeviceInstance' => DeviceInstance,
        'Mapping' => Mapping,
        'Meter' => Meter,
        # 'Report' => Report,
        'Reports' => Reports,
        # 'Rule' => Rule,
        'Rules' => Rules,
        # 'User' => User,
        'Users' => Users,
        'Utility' => Utility,
        'Customers'=> Customers,
        'CustomApis'=> CustomApis
        # 'Customer'=> Customer
      }
      case resp
      when Array
        resp.map { |i| convert_to_machineshop_object(i, auth_token, type) }
      when Hash
        # Try converting to a known object class.  If none available, fall back to generic APIResource
        if klass_name = type
          klass = types[klass_name]
        end
        klass ||= MachineShopObject
        klass.construct_from(resp, auth_token)
      else
        resp
      end
    end

    def self.file_readable(file)
      begin
        File.open(file) { |f| }
      rescue
        false
      else
        true
      end
    end

    def self.symbolize_names(object)
      case object
      when Hash
        new = {}
        object.each do |key, value|
          key = (key.to_sym rescue key) || key
          new[key] = symbolize_names(value)
        end
        new
      when Array
        object.map { |value| symbolize_names(value) }
      else
        object
      end
    end

    def self.url_encode(key)
      URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end

    def self.flatten_params(params, parent_key=nil)
      result = []
      params.each do |key, value|
        calculated_key = parent_key ? "#{parent_key}[#{url_encode(key)}]" : url_encode(key)
        if value.is_a?(Hash)
          result += flatten_params(value, calculated_key)
        elsif value.is_a?(Array)
          result += flatten_params_array(value, calculated_key)
        else
          result << [calculated_key, value]
        end
      end
      result
    end

    def self.flatten_params_array(value, calculated_key)
      result = []
      value.each do |elem|
        if elem.is_a?(Hash)
          result += flatten_params(elem, calculated_key)
        elsif elem.is_a?(Array)
          result += flatten_params_array(elem, calculated_key)
        else
          result << ["#{calculated_key}[]", elem]
        end
      end
      result
    end

    def self.get_klass_from_url(url)
      id=nil
      klass=nil
      splitted = url.split('/')
      klass = splitted[-1]
      if /[0-9]/.match(klass)
        id=splitted[-1]

        if splitted[-3]=="rule"
          klass="rule"
        else
          klass = splitted[-2]
        end
      end
      return id,klass
    end

    #Check if db_connected
    def self.db_connected?
        db_connected = true
      if MachineShop.configuration.enable_caching
        begin
          MachineShop::Database.new
        rescue DatabaseError =>e
          # puts e.message
          db_connected= false
        rescue SchemaError =>e
          # puts e.message
          # db_connected=true
        end
      else
        db_connected = false
      end

      db_connected
    end


    def self.valid_endpoint(name,auth_token,verb,params)
      if Util.db_connected?
        endpoints_upto_date=false

        ApiRequest.cache("/gem/routes/#{MachineShop.configuration.base_version}", auth_token, MachineShop.configuration.custom_endpoints_cache_time) do
          #time not expired, cached routes are oke
          endpoints_upto_date = true
        end

        if !endpoints_upto_date
          #request the endpoints
          MachineShop::EndPoints.all(MachineShop.configuration.base_version,auth_token)

        end

        endpoint = ApiEndpoint.where(:verb=>verb).where(:auth_token=>auth_token).where("api_endpoints.endpoint LIKE :endpoint", {:endpoint => "/#{name}%"}).take(1)
        if !endpoint.empty?
          splitEndpoints = (endpoint[0].endpoint).split("/").reject{|val| val=="" }
          if splitEndpoints[0]==name
            url="/"
            key=0
            splitEndpoints.each do |v|
              if v.start_with? ":" #parameter
                if params[key]
                  url+=params[key]
                  key+=1
                else
                  raise APIError.new("Invalid parameters, Please provide value for #{v}")
                end
              else
                url+="#{v}/"
              end
            end
          end
          return url
        else
          raise APIError.new("Invalid url request")
          return false
        end
      end
    end

  end
end

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

