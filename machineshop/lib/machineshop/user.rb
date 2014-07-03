module MachineShop
  class User < APIResource
    
    # Specific API calls
    def self.authenticate(user_hash)
      #user_hash is => { email: email, password: password }
      response = MachineShop.gem_post(authenticate_url, nil, user_hash)            
      auth_token = response[:authentication_token]
      id = response[:_id]
      
      return auth_token, self.retrieve(id, auth_token)
    end
    
    def self.all_roles(auth_token)
      MachineShop.gem_get(self.role_url, auth_token)
    end
    
    def all_roles
      MachineShop.gem_get(self.class.role_url, @auth_token)
    end       
    
    def device_instances(filters={})
      filters.merge!(:user_id => self.id)
      MachineShop::DeviceInstance.all(filters, @auth_token)
    end
    
    def meters(filters={})
      filters.merge!(:user_id => self.id)
      MachineShop::Meter.all(filters, @auth_token)
    end
    
    private

    def self.authenticate_url
      '/user_session/user/authenticate'
    end

    def self.role_url
      '/platform/role'
    end
    
  end
end