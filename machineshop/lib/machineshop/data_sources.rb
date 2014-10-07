module MachineShop
  class DataSources < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create
    include MachineShop::APIOperations::Update
    # include MachineShop::APIOperations::Delete
    
    # Specific API calls
    
    def report_count(params)      
      MachineShop.gem_get(report_count_url, @auth_token, params)
    end
    
    def reports(filters={})
      filters.merge!(:device_instance_id => self.id)
      MachineShop::Report.all(filters, @auth_token)
    end
    
    def meters(filters={})
      filters.merge!(:device_instance_id => self.id)
      MachineShop::Meter.all(filters, @auth_token)
    end

    def delete
      MachineShop.gem_delete("/platform/data_sources/#{self.id}", @auth_token,{})
    end

   
    def self.update(id,auth_token,params={})
      response = MachineShop.gem_put(self.url+"/#{id}", auth_token, params)
      Util.convert_to_machineshop_object(response, auth_token, self.class_name)
    end

    # def self.delete(name,auth_token)
    #   response = MachineShop.gem_delete(self.url+"/#{name}", auth_token, {})
    # end

    def self.create_email_data_source(params, auth_token)
      MachineShop.gem_post(email_data_source_url, auth_token, params)
    end

    private

    def report_count_url
      url + '/report_count'
    end

    def email_data_source_url
      '/platform/email_data_sources'
    end


  end
end
