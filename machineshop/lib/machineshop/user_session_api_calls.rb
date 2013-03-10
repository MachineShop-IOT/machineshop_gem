require "base64"
require 'json'
require 'rest_client'

module MachineShop
  module ApiCalls
    # Specific API calls    
    def self.post_authenticate(user_hash)
      url = user_session_url + "/user/authenticate"
      post url, headers, user_hash
    end
  end
end