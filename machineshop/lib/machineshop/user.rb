module MachineShop
  class User < APIResource
    
    # Specific API calls
    def self.authenticate(user_hash)      
      response = MachineShop.post(authenticate_url, nil, user_hash)            
      auth_token = response[:authentication_token]
      id = response[:_id]
      
      return auth_token, self.retrieve(id, auth_token)
    end
    
    def self.all_roles(auth_token)
      MachineShop.get(self.role_url, auth_token)
    end
    
    def all_roles
      MachineShop.get(self.class.role_url, @auth_token)
    end
    
    def device_instances
      MachineShop.get(url + '/device_instances', @auth_token)
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