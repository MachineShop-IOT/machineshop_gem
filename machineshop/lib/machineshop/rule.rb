module MachineShop
  class Rule < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create
    include MachineShop::APIOperations::Delete

=begin
    # Specific API calls
    def get_rules(auth_token)
      url = platform_url + "/rule"
      MachineShop.get(url,auth_token)
      #get url, auth_token
    end
=end

    def self.platform_url
      '/platform'
    end

=begin
    def get_rule(auth_token, id)
      url = platform_url + "/rule/#{id}"
      MachineShop.get(url, auth_token)
    end
=end

    def self.get_join_rule_conditions(auth_token)
      url = platform_url + "/rule/join_rule_conditions"
      MachineShop.get(url, auth_token)
    end

    def self.get_comparison_rule_conditions(auth_token)
      url = platform_url + "/rule/comparison_rule_conditions"
      MachineShop.get(url, auth_token)
    end

    def self.get_deleted(auth_token)
      url = platform_url + "/rule/deleted"
      MachineShop.get(url, auth_token)
    end

    def self.get_by_device_instance(auth_token,id)
      url = platform_url + "/rule/device_instance/#{id}"
      MachineShop.get(url, auth_token)
    end

    def post_rule(auth_token, rule_hash)
      url = platform_url + "/rule"
      MachineShop.post(url, auth_token, rule_hash)
    end

    def delete_rule(auth_token, id)
      url = platform_url + "/rule/#{id}"
      MachineShop.delete(url, auth_token)
    end

  end
end