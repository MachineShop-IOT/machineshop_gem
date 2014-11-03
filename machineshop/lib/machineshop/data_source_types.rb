module MachineShop
  class DataSourceTypes < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create
    include MachineShop::APIOperations::Update
    include MachineShop::APIOperations::Delete


    def create_data_source(params)
      params.merge!({:data_source_type => self.id})
      DataSources.create(params, @auth_token)
    end

    def create_email_data_source(params)
      params.merge!({:data_source_type => self.id})
      MachineShop.gem_post(email_data_source_url, @auth_token, params)
    end

    def self.update(id,auth_token,params={})
      response = MachineShop.gem_put(self.url+"/#{id}", auth_token, params)
      Util.convert_to_machineshop_object(response, auth_token, self.class_name)
    end

    def self.delete_data_source_type(id, auth_token)
      response = MachineShop.gem_delete(self.url + "/#{id}", auth_token, {})
    end

    private
    def self.url
      '/platform/data_source_types'
    end

    def email_data_source_url
      '/platform/email_data_sources'
    end

  end
end
