require "base64"
require 'json'
require 'rest_client'

module MachineShop
  module ApiCalls
    class << self
      # Specific API calls
      def post_authenticate(user_hash)
        url = user_session_url + "/user/authenticate"
        post url, nil, user_hash
      end
    end
  end
end