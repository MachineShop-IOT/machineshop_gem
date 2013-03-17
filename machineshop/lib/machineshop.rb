require "machineshop/version"

require 'cgi'
require 'set'
require 'openssl'
require 'rest_client'
require "base64"
require 'rest_client'
require "addressable/uri"
require 'multi_json'

# API operations
require 'machineshop/api_operations/create'
require 'machineshop/api_operations/delete'
require 'machineshop/api_operations/list'

# Resources

require 'machineshop/machineshop_object'
require 'machineshop/api_resource'
require 'machineshop/device_instance'
require 'machineshop/device'
require 'machineshop/machineshop_object'
require 'machineshop/mapping'
require 'machineshop/meter'
require 'machineshop/report'
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


module MachineShop
  class << self
    @@api_base_url = 'https://api.machineshop.io/api/v0'
   
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
        opts = nil      
        api_uri = api_base_url + url
        headers = self.headers(auth_token)
        if http_verb == :get          
          if (body_hash && !body_hash.empty?)
            uri = Addressable::URI.new
            uri.query_values = body_hash
            api_uri += "?" + uri.query
          end
          
          puts
          puts "verb: get"
          puts "url: #{api_uri}" 
          puts "headers: #{headers}"
          
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

            puts
            puts "verb: #{http_verb}"
            puts "url: #{api_uri}" 
            puts "body_json: #{MachineShop::JSON.dump(body_hash)}"
            puts "headers: #{headers}"                                 
          end
          
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
            rcode = response.code
            begin
              # Would use :symbolize_names => true, but apparently there is
              # some library out there that makes symbolize_names not work.
              resp = MachineShop::JSON.load(rbody)
              resp = Util.symbolize_names(resp)
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
    rescue MultiJson::DecodeError, StripeError
      raise APIError.new("Invalid response object from API: #{rbody.inspect} (HTTP response code was #{rcode})", rcode, rbody)
    end

    case rcode
    when 400, 404 then
      raise invalid_request_error(error, rcode, rbody, error_obj)
    when 401
      raise authentication_error(error, rcode, rbody, error_obj)
    when 402
      # TODO Come up with errors
      #raise card_error(error, rcode, rbody, error_obj)
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
      message = "Could not connect to Stripe (#{@@api_base}).  Please check your internet connection and try again.  If this problem persists, you should check Stripe's service status at https://twitter.com/stripestatus, or let us know at support@stripe.com."
    when RestClient::SSLCertificateNotVerified
      message = "Could not verify Stripe's SSL certificate.  Please make sure that your network is not intercepting certificates.  (Try going to https://api.stripe.com/v1 in your browser.)  If this problem persists, let us know at support@stripe.com."
    when SocketError
      message = "Unexpected error communicating when trying to connect to Stripe.  HINT: You may be seeing this message because your DNS is not working.  To check, try running 'host stripe.com' from the command line."
    else
      message = "Unexpected error communicating with Stripe.  If this problem persists, let us know at support@stripe.com."
    end
    message += "\n\n(Network error: #{e.message})"
    raise APIConnectionError.new(message)
  end
  
  
  
  end
end
