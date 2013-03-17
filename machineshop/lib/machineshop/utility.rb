module MachineShop
  class Utility
    def self.email(params={}, auth_token)
      MachineShop.post(email_url, auth_token, params)
    end

    def self.sms(params={}, auth_token)
      MachineShop.post(sms_url, auth_token, params)
    end

    private

    def self.email_url
      url + '/payload_fields'
    end

    def self.sms_url
      url + '/SMS'
    end

    def self.url
      '/platform/utility'
    end

  end
end