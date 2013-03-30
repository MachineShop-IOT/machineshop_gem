module MachineShop
  class Utility < APIResource
    def self.email(params={}, auth_token)
      MachineShop.post(email_url, auth_token, params)
    end

    def self.sms(params={}, auth_token)
      MachineShop.post(sms_url, auth_token, params)
    end

    private

    def self.email_url
      url + '/email'
    end

    def self.sms_url
      url + '/SMS'
    end    
    
    def refresh      
      raise NotImplementedError.new('Utility is a helper api.  You should not perform this action on it')
    end

    def self.retrieve(id, auth_token=nil)
       raise NotImplementedError.new('Utility is a helper api.  You should not perform this action on it')
    end

  end
end