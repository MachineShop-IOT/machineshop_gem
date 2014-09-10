module MachineShop
  class DataSourceTypes < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create
    include MachineShop::APIOperations::Delete


    #  def create_data_source_type(params)
    #   ap "inside create_data_source"
    #   ap params
    #   params.merge!({:device_id => self.id})
    #   DeviceInstance.create(params, @auth_token)
    # end

    # def create_email_data_source(params)
    #   params.merge!({:device_id => self.id})
    #   DeviceInstance.create(params, @auth_token)
    # end



     def create_data_source(params)
      ap "yaha aayo "
      params.merge!({:data_source_type => self.id})
      # ap params
      DataSources.create(params, @auth_token)
    end

     def create_email_data_source(params)
      ap "email data source ma aayo "
      params.merge!({:data_source_type => self.id})
      MachineShop.post(email_data_source_url, @auth_token, params)
      # ap params
      # DataSources.create(params, @auth_token)
    end

    


    private
    def self.url
      '/platform/data_source_types'
    end

    def email_data_source_url
      '/platform/email_data_sources'
    end


    # private

    # def report_count_url
    #   url + '/report_count'
    # end

  end
end
