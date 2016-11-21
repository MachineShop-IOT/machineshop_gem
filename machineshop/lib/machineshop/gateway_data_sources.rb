module MachineShop
  class GatewayDataSources < APIResource
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

    def self.get_attached_data_sources(gateway_data_source_id, auth_token)
      response = MachineShop.gem_get("/platform/gateway_data_sources/#{gateway_data_source_id}/attached_data_sources", auth_token)
      Util.convert_to_machineshop_object(response, auth_token, self.class_name)
    end

    def self.send_config(unique_id, auth_token)
      MachineShop.gem_get("/platform/gateway_data_sources/#{unique_id}/config", auth_token)
    end

    def self.reset_gateway(id, auth_token)
      MachineShop.gem_post("/platform/gateway_data_sources/#{id}/reset", auth_token, {})
    end

    def self.attach_data_sources(auth_token, params={})
      MachineShop.gem_post("/platform/data_sources", auth_token, params)
    end

    def self.update_attached_data_sources(id, parent_gateway_id, auth_token, params={})
      response = MachineShop.gem_put("/platform/gateway_data_sources/#{parent_gateway_id}/attached_data_sources/#{id}", auth_token, params)
      Util.convert_to_machineshop_object(response, auth_token, self.class_name)
    end

    def self.remove_attached_data_source(id, ds_id, auth_token)
      MachineShop.gem_delete("/platform/gateway_data_sources/#{id}/attached_data_sources/#{ds_id}", auth_token)
    end

    def self.data_reset(id, auth_token, params={})
      MachineShop.gem_post("/platform/gateway_data_sources/#{id}/data_reset", auth_token, params)
    end

    def self.initiate_log_upload(id, auth_token, params={})
      MachineShop.gem_post("/platform/gateway_data_sources/#{id}/log_upload", auth_token, params)
    end

    def self.change_log_level(id, log_level, auth_token, params={})
      MachineShop.gem_post("/platform/gateway_data_sources/#{id}/log_level/#{log_level}", auth_token, params)
    end

    def self.download_log_files(id, auth_token)
      MachineShop.gem_get("/platform/gateway_data_sources/#{id}/logs", auth_token)
    end

    def self.list_firmware(id, auth_token)
      MachineShop.gem_get("/platform/gateway_data_sources/#{id}/firmware", auth_token)
    end

    def self.list_edge_updates(id, auth_token)
      MachineShop.gem_get("/platform/gateway_data_sources/#{id}/list_edge_updates", auth_token)
    end

    def self.firmware_update(id, auth_token, params={})
      MachineShop.gem_post("/platform/gateway_data_sources/#{id}/update_firmware", auth_token, params)
    end

    def self.edge_update(id, auth_token, params={})
      MachineShop.gem_post("/platform/gateway_data_sources/#{id}/update_edge_version", auth_token, params)
    end

  end
end
