module MachineShop
  class Device < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create    
    
    # Specific API calls            
    def payload_fields(params=nil)
      MachineShop.get(payload_fields_url, @auth_token, params)
    end
    
    private

    def payload_fields_url
      url + '/payload_fields'
    end


  end
end