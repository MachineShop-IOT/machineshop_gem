module MachineShop
  class Mapping
    # Specific API calls
    def self.geocode(params={}, auth_token)
      MachineShop.get(geocode_url, auth_token, params)
    end

    def self.directions(params={}, auth_token)
      MachineShop.get(directions_url, auth_token, params)
    end

    def self.distance(params={}, auth_token)
      MachineShop.get(distance_url, auth_token, params)
    end

    private

    def self.geocode_url
      url + '/geocode/json'
    end

    def self.directions_url
      url + '/directions/json'
    end

    def self.distance_url
      url + '/distance/json'
    end

    def self.url
      '/platform/google'
    end
  end
end