module MachineShop
  def self.auth_token=(auth_token)    
    ApiCalls.auth_token= auth_token
  end

  def self.auth_token
    ApiCalls.auth_token
  end

  def self.api_base=(api_base)
    ApiCalls.api_base= api_base
  end

  def self.api_base
    ApiCalls.api_base
  end

  def self.platform_endpoint=(platform_endpoint)
    ApiCalls.platform_endpoint= platform_endpoint
  end

  def self.platform_endpoint
    ApiCalls.platform_endpoint
  end
  
  def self.user_session_endpoint=(user_session_endpoint)
    ApiCalls.user_session_endpoint= user_session_endpoint
  end

  def self.user_session_endpoint
    ApiCalls.user_session_endpoint
  end

  module ApiCalls
    @@auth_token = nil
    @@api_base = 'https://api.machineshop.io'
    @@platform_endpoint ='/api/v0/platform'
    @@user_session_endpoint ='/api/v0/user_session'
    
    def self.platform_url
      @@api_base + @@platform_endpoint
    end
    
    def self.user_session_url
      @@api_base + @@user_session_endpoint
    end

    def self.auth_token=(auth_token)      
      @@auth_token = auth_token
    end

    def self.auth_token
      @@auth_token
    end

    def self.api_base=(api_base)
      @@api_base = api_base
    end

    def self.api_base
      @@api_base
    end

    def self.platform_endpoint=(platform_endpoint)
      @@platform_endpoint = platform_endpoint
    end

    def self.platform_endpoint
      @@platform_endpoint
    end
    
    def self.user_session_endpoint=(user_session_endpoint)
      @@user_session_endpoint = user_session_endpoint
    end

    def self.user_session_endpoint
      @@user_session_endpoint
    end

    def self.headers
      header ={:content_type => :json,
        :accept => :json}
      header[:authorization] = "Basic " + Base64.encode64(@@auth_token + ':X') if @@auth_token
      header
    end
  end
end