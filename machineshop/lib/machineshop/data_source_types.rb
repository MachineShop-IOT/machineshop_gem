module MachineShop
  class DataSourceTypes < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create
    include MachineShop::APIOperations::Delete


     def create_data_source(params)
      params.merge!({:data_source_type => self.id})
      DataSources.create(params, @auth_token)
    end

     def create_email_data_source(params)
      params.merge!({:data_source_type => self.id})
      MachineShop.post(email_data_source_url, @auth_token, params)
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
