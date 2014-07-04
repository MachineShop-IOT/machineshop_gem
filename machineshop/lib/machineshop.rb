require "machineshop/version"

require 'awesome_print'
require 'will_paginate'

require 'cgi'
require 'set'
require 'openssl'
require 'rest_client'
require "base64"
require "addressable/uri"
require 'multi_json'

#configurations
require 'machineshop/configuration'
#database
require 'machineshop/database'

# API operations
require 'machineshop/api_operations/create'
require 'machineshop/api_operations/delete'
require 'machineshop/api_operations/list'
require 'machineshop/api_operations/update'

# Resources

require 'machineshop/machineshop_object'
require 'machineshop/api_resource'
require 'machineshop/device_instance'
require 'machineshop/device'
require 'machineshop/machineshop_object'
require 'machineshop/mapping'
require 'machineshop/meter'
require 'machineshop/report'
require 'machineshop/customer'
require 'machineshop/rule'
require 'machineshop/user'
require 'machineshop/utility'
require 'machineshop/json'
require 'machineshop/util'
require 'machineshop/end_points'

# Errors
require 'machineshop/errors/machineshop_error'
require 'machineshop/errors/api_error'
require 'machineshop/errors/invalid_request_error'
require 'machineshop/errors/authentication_error'
require 'machineshop/errors/api_connection_error'

#Models
require 'machineshop/models/api_request'
require 'machineshop/models/api_endpoint'


module MachineShop
  class << self
    # @@api_base_url = 'http://api.machineshop.io/api/v0'
    @@api_base_url = 'http://stage.services.machineshop.io/api/v0'

    #configs starts
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    #reset the config object
    def reset
      Configuration.new
    end

    #configs ends

    def api_base_url=(api_base_url)
      @@api_base_url = api_base_url
    end

    def api_base_url
      @@api_base_url
    end

    #For Custom endpoints
    def get(name, auth_token, *params)
      url = Util.valid_endpoint(name,auth_token,:get, params)
      platform_request(url, auth_token, nil, :get)
    end

    def post(name,auth_token, body_hash)
      url = Util.valid_endpoint(name,auth_token,:post,[])
      platform_request(url, auth_token,body_hash,:post)
    end

    def put(name,auth_token,*params,body_hash)
      url = Util.valid_endpoint(name,auth_token,:put,params)
      platform_request(url, auth_token,body_hash,:put)
    end

    def delete(name,auth_token,*params)
      url = Util.valid_endpoint(name,auth_token,:delete,params)
      platform_request(url, auth_token, nil ,:delete)
    end

    #Call for the predefined request
    def gem_get(url, auth_token, body_hash=nil)
      platform_request(url, auth_token, body_hash)
    end

    def gem_post(url, auth_token, body_hash)
      platform_request(url, auth_token, body_hash, :post)
    end

    def gem_delete(url, auth_token, body_hash)
      platform_request(url, auth_token, body_hash, :delete)
    end

    def gem_put(url, auth_token, body_hash)
      platform_request(url, auth_token, body_hash, :put)
    end

    def headers(auth_token)
      header ={:content_type => :json,
      :accept => :json}
      header.merge!({ authorization: "Basic " + Base64.encode64(auth_token + ':X') }) if auth_token
      header
    end

    def platform_request(url, auth_token, body_hash=nil, http_verb=:get )
      rbody=nil
      cachedContent = :true
      # ApiRequest.cache(url,MachineShop.configuration.expiry_time)
      if http_verb==:get

        if Util.db_connected?

          ApiRequest.cache(url, auth_token, MachineShop.configuration.expiry_time) do
            puts "Not expired , calling from local "
            rbody = get_from_cache(url,body_hash,auth_token)
            rcode="200"
          end
        end

      end
      if (rbody.nil? || rbody.empty?)
        cachedContent=:false
        ap "Not found in local, calling from API"
        # ap "body_hash: #{body_hash}"
        opts = nil
        api_uri = api_base_url + url
        headers = self.headers(auth_token)
        if http_verb == :get
          if (body_hash && !body_hash.empty?)
            uri = Addressable::URI.new
            uri.query_values = body_hash
            api_uri += "?" + uri.query
          end

          opts = {
            :method => :get,
            :url => api_uri,
            :headers => headers,
            :open_timeout => 30,
            :timeout => 80
          }

        else
          opts = {
            :method => http_verb,
            :url => api_uri,
            :headers => headers,
            :open_timeout => 30,
            :payload => MachineShop::JSON.dump(body_hash),
            :timeout => 80
          }

        end

        puts "request params: #{opts} "

        begin
          response = execute_request(opts)

        rescue SocketError => e
          self.handle_restclient_error(e)
        rescue NoMethodError => e
          # Work around RestClient bug
          if e.message =~ /\WRequestFailed\W/
            e = APIConnectionError.new('Unexpected HTTP response code')
            self.handle_restclient_error(e)
          else
            raise
          end
        rescue RestClient::ExceptionWithResponse => e
          if rcode = e.http_code and rbody = e.http_body
            self.handle_api_error(rcode, rbody)
          else
            self.handle_restclient_error(e)
          end
        rescue RestClient::Exception, Errno::ECONNREFUSED => e
          self.handle_restclient_error(e)
        end

        rbody = response.body
        # puts rbody
        rcode = response.code
      end

      begin
        # Would use :symbolize_names => true, but apparently there is
        # some library out there that makes symbolize_names not work.
        resp = MachineShop::JSON.load(rbody)
        resp ||= {}
        resp = Util.symbolize_names(resp)

        save_into_cache(url,resp,auth_token) if (http_verb == :get && cachedContent==:false)

        resp.merge!({:http_code => rcode}) if resp.is_a?(Hash)
        return resp
      rescue MultiJson::DecodeError
        raise APIError.new("Invalid response object from API: #{rbody.inspect} (HTTP response code was #{rcode})", rcode, rbody)
      end

    end


    def execute_request(opts)
      RestClient::Request.execute(opts)
    end

    def handle_api_error(rcode, rbody)
      begin
        error_obj = MachineShop::JSON.load(rbody)
        error_obj = Util.symbolize_names(error_obj)
        error = error_obj[:error] or raise MachineShopError.new # escape from parsing
      rescue MultiJson::DecodeError, MachineShopError
        raise APIError.new("Invalid response object from API: #{rbody.inspect} (HTTP response code was #{rcode})", rcode, rbody)
      end

      case rcode
      when 400, 404 then
        raise invalid_request_error(error, rcode, rbody, error_obj)
      when 401
        raise authentication_error(error, rcode, rbody, error_obj)
      when 402
        # TODO Come up with errors
      else
        raise api_error(error, rcode, rbody, error_obj)
      end
    end

    def invalid_request_error(error, rcode, rbody, error_obj)
      InvalidRequestError.new(error, error, rcode, rbody, error_obj)
    end

    def authentication_error(error, rcode, rbody, error_obj)
      AuthenticationError.new(error, rcode, rbody, error_obj)
    end

    def api_error(error, rcode, rbody, error_obj)
      APIError.new(error, rcode, rbody, error_obj)
    end

    def handle_restclient_error(e)
      case e
      when RestClient::ServerBrokeConnection, RestClient::RequestTimeout
        message = "Could not connect to MachineShop (#{@@api_base_url}).  Please check your internet connection and try again.  If this problem persists, you should check MachineShop's service status."
      when RestClient::SSLCertificateNotVerified
        message = "Could not verify MachineShops's SSL certificate.  Please make sure that your network is not intercepting certificates."
      when SocketError
        message = "Unexpected error communicating when trying to connect to MachineShop (#{@@api_base_url}).  HINT: You may be seeing this message because your DNS is not working."
      else
        message = "Unexpected error communicating with MachineShop"
      end
      message += "\n\n(Network error: #{e.message})"
      # puts "error message string : #{message}"
      raise APIConnectionError.new(message)
    end


    # Check if the class with the variable exists
    def class_exists?(class_name)
      klass = class_name.constantize
      return klass.is_a?(Class)
    rescue NameError =>e
      return false
    end


    def save_into_cache(url, data,auth_token)
      # ap "inside save into cache"
      id,klass= Util.get_klass_from_url(url)
      if !TABLE_NAME_BLACKLIST.include?(klass)
        if Util.db_connected?

          klass = klass.capitalize+"Cache"
          puts "creating dynamic class #{klass}"


          modelClass ||= (Object.const_set klass, Class.new(ActiveRecord::Base))
          modelClass.inheritance_column = :_type_disabled
          #Because 'type' is reserved for storing the class in case of inheritance and our array has "TYPE" key

          if ActiveRecord::Base.connection.table_exists? CGI.escape(klass.pluralize.underscore)

            puts "db table #{klass.pluralize.underscore} exists"
            if data.class ==Hash

              findId = data[:_id] || data["_id"]
              @activeObject = modelClass.find_by(_id: findId) || modelClass.new
              data.each do |k,v|

                val=nil

                if v.class==Array
                  val = v.to_json
                elsif v.class==Hash
                  val = v.to_json
                else
                  val=v
                end
                @activeObject.send("#{k}=",val)
              end


            else
              data.each do |data_arr|

                if data_arr

                  if data_arr.first.class==String && data_arr.class==Array
                    ap data_arr.as_json

                    @activeObject = modelClass.find_by(rule_condition: data_arr.select{|k| k.include?("rule_condition")})  || modelClass.new
                    data_arr.each do |k|

                      if k.include?("rule_condition")
                        @activeObject.rule_condition = k
                      else
                        @activeObject.rule_description=k
                      end
                    end


                  else
                    if data_arr.class!=String
                      findId = data_arr[:_id] || data_arr["_id"]
                      @activeObject = modelClass.find_by(_id: findId) || modelClass.new
                      data_arr.each do |k,v|

                        val=nil

                        if v.class==Array
                          val = v.to_json
                        elsif v.class==Hash
                          val = v.to_json
                        else
                          val=v
                        end

                        @activeObject.send("#{k}=",val)
                      end
                    end
                  end
                end
              end
            end


            @activeObject.send("auth_token=",auth_token)
            @activeObject.save

          end #if ActiveRecord ends

        end #if db_connected ends
      end #if !TABLE_NAME_BLACKLIST.include? ends
    end


    def get_from_cache(url, body_hash,auth_token)
      ap "inside get_from_cache"

      result =Array.new
      id,klass= Util.get_klass_from_url(url)
      ap "klass from URL "
      ap klass

      if !TABLE_NAME_BLACKLIST.include?(klass)
        ap "inside whitelist"


        if Util.db_connected?

          klass = klass.capitalize+"Cache"

          modelClass = Object.const_set klass, Class.new(ActiveRecord::Base)
          modelClass.inheritance_column = :_type_disabled

          data_exist=false
          if ActiveRecord::Base.connection.table_exists? CGI.escape(klass.pluralize.underscore)
            puts "db:table #{klass.pluralize} exists"
            resp= nil
            if id
              resp = modelClass.find_by(_id: id, auth_token: auth_token)
              data_exist=true if resp
            else
              # pagination = body_hash.select{|k| k==:per_page || k==:page} if body_hash
              resp = modelClass.where(parse_query_string(body_hash,auth_token))
              data_exist = true if resp.exists?
            end

            if data_exist
              if(klass.include?("rule_condition"))
                resp.each do |rTemp|
                  temp = Array.new
                  temp.push rTemp["rule_description"]
                  temp.push rTemp["rule_condition"]
                  result << temp
                end
                result = result.to_json(:except=>[:id]) if result
              else
                result = resp.to_json(:except=>[:id]) if resp
              end

            end
          end
        end
      end
      return result
    end

    TABLE_NAME_BLACKLIST = ["user","routes"]
    QUERY_STRING_BLACKLIST = [
      'page',
      'per_page'
    ]

    def parse_query_string(query_params,auth_token)

      search_parms = {}
      if query_params
        params = Hash[query_params.map{ |k, v| [k.to_s, v] }]
        operators = ["gt", "gte", "lt", "lte"]

        xs = params.reject { |k,_| QUERY_STRING_BLACKLIST.include?(k) }
        xs.each do |key,value|
          tokens = key.split('_')
          if tokens.nil? || tokens.length == 1
            search_parms[key] = value
          else
            token_length = tokens[tokens.length-1].length-1
            if operators.include?(tokens[tokens.length-1])
              operator = "$" + tokens[tokens.length-1]
              new_key = key[0,key.length-token_length-2].to_sym
              search_parms[new_key] = { operator => value }
            elsif tokens[tokens.length-1] == "between" && value.split("_").length > 1
              new_key = key[0,key.length-token_length-2].to_sym
              vals = value.split("_")
              search_parms[new_key] = {"$gte" => vals[0], "$lte" => vals[1]}
            else
              search_parms[key] = value
            end
          end
        end
      end
      #append auth_token = auth_token part as well
      search_parms['auth_token']=auth_token
      search_parms
    end


  end
end
