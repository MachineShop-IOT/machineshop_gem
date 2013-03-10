require "base64"
require 'json'
require 'rest_client'

module MachineShop
  module ApiCalls
    # Specific API calls
    def self.get_rules
      url = Config.platform_url + "/rule"
      get url, Config.headers
    end

    def self.get_rule(id)
      url = Config.platform_url + "/rule/#{id}"
      get url, Config.headers
    end

    def self.get_device_instances
      url = Config.platform_url + "/device_instance"
      get url, Config.headers
    end

    def self.get_device(id)
      url = Config.platform_url + "/rule"
      get url, Config.headers
    end

    def self.get_device
      url = platform_url + "/device"
      get url, headers
    end

    def self.get_payload(device_id)
      url = Config.platform_url + "/device/#{device_id}/payload_fields"
      get url, Config.headers
    end

    def self.get_join_rule_conditions
      url = Config.platform_url + "/rule/join_rule_conditions"
      get url, Config.headers
    end

    def self.get_comparison_rule_conditions
      url = Config.platform_url + "/rule/comparison_rule_conditions"
      get url, Config.headers
    end

    def self.post_rule(rule_hash)
      url = Config.platform_url + "/rule"
      post url, Config.headers, rule_hash
    end

    def self.delete_rule(id)
      url = Config.platform_url + "/rule/#{id}"
      delete url, Config.headers
    end

    def self.post_device(device_hash)
      url = platform_url + "/device"
      post url, headers, device_hash
    end
  end
end