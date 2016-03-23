module MachineShop
  class GatewayConfigs < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create
    include MachineShop::APIOperations::Update
    include MachineShop::APIOperations::Delete

    def self.update(id,auth_token,params={})
      response = MachineShop.gem_put(self.url+"/#{id}", auth_token, params)
      Util.convert_to_machineshop_object(response, auth_token, self.class_name)
    end

    def self.delete(id, auth_token)
      MachineShop.gem_delete(self.url + "/#{id}", auth_token, {})
    end

    def self.set_gateway_configs(auth_token, params={})
      MachineShop.gem_put('/platform/gateway_data_sources/set_gateway_configs', auth_token, params)
    end

    def self.set_configs(auth_token, params={})
      MachineShop.gem_put('/platform/gateway_data_sources/set_configs', auth_token, params)
    end

    def self.reset_group(id, auth_token)
      MachineShop.gem_post("/platform/gateway_configs/#{id}/reset", auth_token, {})
    end

    def self.send_group_config(id, auth_token)
      MachineShop.gem_post("/platform/gateway_configs/#{id}/send_gateway_config", auth_token, {})
    end

  end
end
