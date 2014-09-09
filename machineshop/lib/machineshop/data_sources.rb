module MachineShop
  class DataSources < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create
    include MachineShop::APIOperations::Delete
    
    # Specific API calls
    
    def report_count(params)      
      MachineShop.get(report_count_url, @auth_token, params)
    end
    
    def reports(filters={})
      filters.merge!(:device_instance_id => self.id)
      MachineShop::Report.all(filters, @auth_token)
    end
    
    def meters(filters={})
      filters.merge!(:device_instance_id => self.id)
      MachineShop::Meter.all(filters, @auth_token)
    end

     def create_data_source(params)
      ap "inside create_data_source"
      ap params
      params.merge!({:device_id => self.id})
      DeviceInstance.create(params, @auth_token)
    end

    def create_email_data_source(params)
      params.merge!({:device_id => self.id})
      DeviceInstance.create(params, @auth_token)
    end

    
    private

    def report_count_url
      url + '/report_count'
    end

  end
end
