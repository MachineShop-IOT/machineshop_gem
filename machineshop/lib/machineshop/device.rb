module MachineShop
  class Device < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create    
    
    # Specific API calls            
    def payload_fields(params=nil)
      MachineShop.get(payload_fields_url, @auth_token, params)
    end
    
    def create_instance(params)
      params.merge!({:device_id => self.id})
      
      puts "params: #{params}"
      
      DeviceInstance.create(params, @auth_token)
    end
    
    def instances(params={})
      params.merge!({:device_id => self.id})
      DeviceInstance.all(params, @auth_token)
    end
    
    private

    def payload_fields_url
      url + '/payload_fields'
    end


  end
end