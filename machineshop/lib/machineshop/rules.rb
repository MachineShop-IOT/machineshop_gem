module MachineShop
  class Rules < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create
    include MachineShop::APIOperations::Delete
    include MachineShop::APIOperations::Update

   

    def self.get_join_rule_conditions(auth_token)
      url = platform_url + "/join_rule_conditions"
      MachineShop.gem_get(url, auth_token)
    end

    def self.get_comparison_rule_conditions(auth_token)
      url = platform_url + "/comparison_rule_conditions"
      MachineShop.gem_get(url, auth_token)
    end

    def self.get_deleted(auth_token)
      url = platform_url + "/deleted"
      MachineShop.gem_get(url, auth_token)
    end

    # def self.get_by_device_instance(auth_token,id)
    #   url = platform_url + "/device_instance/#{id}"
    #   MachineShop.gem_get(url, auth_token)
    # end

    def self.get_by_data_source(auth_token,id)
      url = platform_url + "/data_sources/#{id}"
      MachineShop.gem_get(url, auth_token)
    end

    def post_rule(auth_token, rule_hash)
      url = platform_url
      MachineShop.gem_post(url, auth_token, rule_hash)
    end

    def self.delete_rule(auth_token, id)
      url = platform_url + "/#{id}"
      MachineShop.gem_delete(url, auth_token)
    end

    def self.update(id,auth_token,params={})
      response = MachineShop.gem_put(platform_url+"/#{id}", auth_token, params)
      Util.convert_to_machineshop_object(response, auth_token, self.class_name)
    end

    private
     def self.platform_url
      '/platform/rules'
    end

  end
end