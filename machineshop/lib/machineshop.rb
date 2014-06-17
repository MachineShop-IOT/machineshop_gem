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

# Errors
require 'machineshop/errors/machineshop_error'
require 'machineshop/errors/api_error'
require 'machineshop/errors/invalid_request_error'
require 'machineshop/errors/authentication_error'
require 'machineshop/errors/api_connection_error'

#Models
# require 'machineshop/models/people'
# require 'machineshop/models/device_cache'


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

    def get(url, auth_token, body_hash=nil)
      platform_request(url, auth_token, body_hash)
    end

    def post(url, auth_token, body_hash)
      platform_request(url, auth_token, body_hash, :post)
    end

    def delete(url, auth_token, body_hash)
      platform_request(url, auth_token, body_hash, :delete)
    end

    def put(url, auth_token, body_hash)
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
      if http_verb==:get

        rbody = getFromCache(url,body_hash)
        # rbody = nil
        rcode="202"

      end
      # if !rbody
      puts rbody
      if (rbody.nil? || rbody.empty?)

        ap "Not found in local, calling from API"

        ap "body_hash: #{body_hash}"
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

        # saveIntoCache(url,resp)

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


    #Check if the class with the variable exists
    # def class_exists?(class_name)
    #   klass = class_name.constantize
    #   return klass.is_a?(Class)
    # rescue NameError =>e
    #   puts "rescue ma gayo #{e.message}"
    #   return false
    # end


    #get the classname from url and get the record if exists


    def saveIntoCache(url, data)
      id=nil
      splitted = url.split('/')
      klass = splitted[-1]

      if /[0-9]/.match(klass)
        klass = splitted[-2]
        id=splitted[-1]
      end
      klass = klass.capitalize+"Cache"
      puts "&&&&&&&& creating dynamic class #{klass} &&&&&&&&&&&"
      modelClass = Object.const_set klass, Class.new(ActiveRecord::Base)

      modelClass.inheritance_column = :_type_disabled
      #Because 'type' is reserved for storing the class in case of inheritance and our array has "TYPE" key
      db = MachineShop::Database.new
      if ActiveRecord::Base.connection.table_exists? CGI.escape(klass.pluralize.underscore)
        puts "db table #{klass.pluralize.underscore} exists"

        data.each do |data_arr|
          if data_arr
            @activeObject = modelClass.find_by(_id: data_arr[:_id]) || modelClass.new
            data_arr.each do |k,v|
              val=nil
              case v
              when Array
                val = v.map { |o| Hash[o.each_pair.to_a] }.to_json
              else
                val =v
              end
              @activeObject.send("#{k}=",val)
            end
            @activeObject.save
          end

        end
      end
    end


    def getFromCache(url, body_hash)
      id=nil
      splitted = url.split('/')
      klass = splitted[-1]

      if /[0-9]/.match(klass)
        klass = splitted[-2]
        id=splitted[-1]
        #the last item is id ,then take -2
      end
      klass = klass.capitalize+"Cache"
      modelClass = Object.const_set klass, Class.new(ActiveRecord::Base)
      modelClass.inheritance_column = :_type_disabled
      db = MachineShop::Database.new
      # puts ActiveRecord::Base.connection.tables
      if ActiveRecord::Base.connection.table_exists? CGI.escape(klass.pluralize.underscore)
        puts "yessss #{klass.pluralize} exists"
        resp= nil
        if id
          resp = modelClass.find_by(_id: id)
        else
          pagination = body_hash.select{|k| k==:per_page || k==:page}
          resp = modelClass.where(parse_query_string body_hash)
          # .paginate(:per_page=>20,:page=>1)
        end
        result = []
        result = resp.to_json(:except=>[:id]) if !(resp.nil? || resp.empty?)
        return result
      end
    end

    QUERY_STRING_BLACKLIST = [
      'page',
      'per_page'
    ]

    def parse_query_string(query_params)
      params = Hash[query_params.map{ |k, v| [k.to_s, v] }]
      search_parms = {}
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
      puts search_parms
      search_parms
    end


  end
end
