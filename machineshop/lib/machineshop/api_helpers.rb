require "base64"
require 'json'
require 'rest_client'
require "addressable/uri"


module MachineShop
  module ApiCalls
    class << self
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
    
      def return_elegant
        JSON.parse(yield, :symbolize_names => true)
      rescue => e
        msg = {
          :error => e.message,
          :backtrace => e.backtrace  
        }
        msg.merge!({
          :response => JSON.parse(e.response)["error"]
          }) if defined? e.response
        
        JSON.generate(msg)   
      end
    
      def platform_request(url, auth_token, body_hash=nil, http_verb=:get )       
        headers = self.headers(auth_token)
        if http_verb == :get
          query_string = "?"
          if body_hash
            uri = Addressable::URI.new
            uri.query_values = body_hash
            url += "?" + uri.query
          end
          return_elegant do
            puts
            puts "verb: get"
            puts "url: #{url}" 
            puts "headers: #{headers}"
            RestClient.get url, headers
          end
        else
          return_elegant do
            puts
            puts "verb: #{http_verb}"
            puts "url: #{url}" 
            puts "body_json: #{body_hash.to_json}"
            puts "headers: #{headers}"
            RestClient.send http_verb, url, body_hash.to_json, headers
          end
        end
      end
    end
  end
end