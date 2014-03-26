module MachineShop
  class Rule < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create
    include MachineShop::APIOperations::Delete

    # Specific API calls
    def get_rules(auth_token)
      url = platform_url + "/rule"
      MachineShop.get(url,auth_token)
      #get url, auth_token
    end

    def platform_url
      '/platform'
    end

    def get_rule(auth_token, id)
      url = platform_url + "/rule/#{id}"
      MachineShop.get(url, auth_token)
    end

    def get_join_rule_conditions(auth_token)
      url = platform_url + "/rule/join_rule_conditions"
      MachineShop.get(url, auth_token)
    end

    def get_comparison_rule_conditions(auth_token)
      url = platform_url + "/rule/comparison_rule_conditions"
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