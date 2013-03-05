require "base64"
require 'json'
module ApiCalls

  HEADERS = {:content_type => :json,
             :accept => :json,
             :authorization => "Basic " + Base64.encode64(CURRENT_USER_AUTH_TOKEN + ':X')} 

  PRODUCTION_PLATFORM_API = "FILL THIS IN"#"https://portal.machineshop.io/api/v0/platform/"

  # def get_rules
  #   platform_request("rule")
  # end

  # def get_rule(id)
  #   platform_request("rule/#{id}")
  # end

  # def get_device_instances
  #   platform_request("/device_instance")
  # end

  # def get_device(id)
  #   puts "GETTING DEVICE #{id}"
  #   platform_request("device/#{id}")
  # end

  # def get_payload(device_id)
  #   platform_request("device/#{device_id}/payload_fields")
  # end

  # def get_join_rule_conditions
  #   platform_request("rule/join_rule_conditions")
  # end

  # def get_comparison_rule_conditions
  #   platform_request("rule/comparison_rule_conditions")
  # end

  # def create_rule(rule_json)
  #   url = "#{PRODUCTION_PLATFORM_API}/rule"
  #   response = RestClient.post url, rule_json, HEADERS
  #   JSON.parse(response, :symbolize_names => true)
  # end

  # def delete_rule(id)
  #   url = "#{PRODUCTION_PLATFORM_API}/rule/#{id}"
  #   RestClient.delete url, HEADERS
  # end

  # def platform_request(endpoint)
  #   url = "#{PRODUCTION_PLATFORM_API}#{endpoint}"
  #   response = RestClient.get url, HEADERS
  #   JSON.parse(response, :symbolize_names => true)
  # end

  def get(endpoint)
    platform_request(endpoint, nil, :get)
  end

  def post(endpoint, body_hash)
    platform_request(endpoint, body_hash, :post)
  end

  def delete(endpoint, body_hash)
    platform_request(endpoint, body_hash, :delete)
  end

  def put(endpoint, body_hash)
    platform_request(endpoint, body_hash, :put)
  end

  def platform_request(endpoint, body_hash, http_verb)
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
      url = "#{PRODUCTION_PLATFORM_API}#{endpoint}"
      response = RestClient.get url, HEADERS
    else
      url = "#{PRODUCTION_PLATFORM_API}#{endpoint}"
      response = RestClient.send(http_verb) url, body_hash.to_json, HEADERS
    end
    JSON.parse(response, :symbolize_names => true)
  end
end
