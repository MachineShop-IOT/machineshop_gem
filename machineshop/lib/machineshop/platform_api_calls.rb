require "base64"
require 'json'
require 'rest_client'

module MachineShop
  module ApiCalls
    class << self
      # Specific API calls
      def get_rules(auth_token)
        url = platform_url + "/rule"
        get url, auth_token
      end

      def get_rule(auth_token, id)
        url = platform_url + "/rule/#{id}"
        get url, auth_token
      end

      def get_device_instances(auth_token)
        url = platform_url + "/device_instance"
        get url, auth_token
      end

      def get_devices(auth_token)
        url = platform_url + "/device"
        get url, auth_token
      end 
      
      def get_device(auth_token, id)
        url = platform_url + "/device/#{id}"
        get url, auth_token
      end      
      
      def get_data_monitor(auth_token, monitor_hash)
        url = platform_url + "/data/monitor"
        get url, auth_token, monitor_hash
      end

      def get_payload(auth_token, device_id)
        url = platform_url + "/device/#{device_id}/payload_fields"
        get url, auth_token
      end

      def get_join_rule_conditions(auth_token)
        url = platform_url + "/rule/join_rule_conditions"
        get url, auth_token
      end

      def get_comparison_rule_conditions(auth_token)
        url = platform_url + "/rule/comparison_rule_conditions"
        get url, auth_token
      end

      def post_rule(auth_token, rule_hash)
        url = platform_url + "/rule"
        post url, auth_token, rule_hash
      end

      def delete_rule(auth_token, id)
        url = platform_url + "/rule/#{id}"
        delete url, auth_token
      end

      def post_device(auth_token, device_hash)
        url = platform_url + "/device"
        post url, auth_token, device_hash
      end
    end
  end
end