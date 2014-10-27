module MachineShop
  class Users < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create
    include MachineShop::APIOperations::Delete
    include MachineShop::APIOperations::Update

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

    def self.new_api_key(user_id,auth_token)
      MachineShop.gem_get("#{self.url}/#{user_id}/new_api_key", auth_token)
    end       
    
    def device_instances(filters={})
      filters.merge!(:user_id => self.id)
      MachineShop::DeviceInstance.all(filters, @auth_token)
    end
    
    def meters(filters={})
      filters.merge!(:user_id => self.id)
      MachineShop::Meter.all(filters, @auth_token)
    end

    def self.update(id,auth_token,params={})
      response = MachineShop.gem_put(self.url+"/#{id}", auth_token, params)
      Util.convert_to_machineshop_object(response, auth_token, self.class_name)
    end


    def self.create_user_logo(user_id, params, auth_token)
      MachineShop.gem_multipart("/platform/users/#{user_id}/logo", auth_token, params)
    end

    def self.delete_user_logo(user_id, auth_token)
      MachineShop.gem_delete("/platform/users/#{user_id}/logo", auth_token)
    end

    def self.check_users(user_hash)
      MachineShop.gem_get("user_session/user/versions", user_hash)
    end

    private

    def self.authenticate_url
      '/user_session/user/authenticate'
    end

    def self.role_url
      '/platform/roles'
    end
    
  end
end