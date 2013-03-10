require "base64"
require 'json'
require 'rest_client'

module ApiCalls
  @@auth_token = nil
  @@api_base = 'https://api.machineshop.io'
  @@platform_endpoint ='/api/v0/platform'

  # Config stuff
  
  def self.platform_url
    @@api_base + @@platform_endpoint
  end

  def self.auth_token=(auth_token)
    @@auth_token = auth_token
  end

  def self.auth_token
    @@auth_token
  end

  def self.api_base=(api_base)
    @@api_base = api_base
  end

  def self.api_base
    @@api_base
  end

  def self.platform_endpoint=(platform_endpoint)
    @@platform_endpoint = platform_endpoint
  end

  def self.platform_endpoint
    @@platform_endpoint
  end

  def self.headers
    {:content_type => :json,
      :accept => :json,
      :authorization => "Basic " + Base64.encode64(@@auth_token + ':X')}
  end


  # Specific API calls

  def self.get_rules
    url = platform_url + "/rule"
    get url, headers
  end

  def self.get_rule(id)
    url = platform_url + "/rule/#{id}"
    get url, headers
  end

  def self.get_device_instances
    url = platform_url + "/device_instance"
    get url, headers
  end

  def self.get_device(id)
    url = platform_url + "/rule"
    get url, headers
  end

  def self.get_device
    url = platform_url + "/device"
    get url, headers
  end

  def self.get_payload(device_id)
    url = platform_url + "device/#{device_id}/payload_fields"
    get url, headers
  end

  def self.get_join_rule_conditions
    url = platform_url + "/rule/join_rule_conditions"
    get url, headers
  end

  def self.get_comparison_rule_conditions
    url = platform_url + "/rule/comparison_rule_conditions"
    get url, headers
  end

  def self.create_rule(rule_json)
    url = platform_url + "/rule"    
    post url headers rule_json
  end

  def self.delete_rule(id)
    url = platform_url + "/rule/#{id}"
    delete url, headers
  end


  # Generic API calls

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

  def self.platform_request(url, headers, body_hash=nil, http_verb=:get )
    puts "url: #{url} body_hash #{body_hash} http_verb #{http_verb} headers: #{headers}"
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
      response = RestClient.get url, headers
    else
      response = RestClient.send http_verb, url, body_hash.to_json, headers
    end
    JSON.parse(response, :symbolize_names => true)
  end
end
