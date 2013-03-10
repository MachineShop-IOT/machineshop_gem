require "base64"
require 'json'
require 'rest_client'


module MachineShop
  module ApiCalls
    def self.get(url, headers)
      platform_request(url, headers)
    end
  
    def self.post(url, headers, body_hash)
      platform_request(url, headers, body_hash, :post)
    end
  
    def self.delete(url, headers, body_hash)
      platform_request(url, headers, body_hash, :delete)
    end
  
    def self.put(url, headers, body_hash)
      platform_request(url, headers, body_hash, :put)
    end
  
    def self.return_elegant
      JSON.parse(yield, :symbolize_names => true)
    rescue => e
      msg = {
        error: e.message,
        response: JSON.parse(e.response)["error"] 
      }
      
      JSON.generate(msg)   
    end
  
    def self.platform_request(url, headers, body_hash=nil, http_verb=:get )       
      if http_verb == :get
        query_string = "?"
        if body_hash
          qa = []
          body_hash.to_a.each do |a|
            qa << a.join('=')
          end
          query_string += qa.join('&')
        endpoint += query_string
        end
        return_elegant do
          RestClient.get url, headers
        end
      else
        return_elegant do
          RestClient.send http_verb, url, body_hash.to_json, headers
        end
      end
    end
  end
end