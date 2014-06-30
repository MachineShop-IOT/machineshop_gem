module MachineShop
  class EndPoints < APIResource
    include MachineShop::APIOperations::List

    # Specific API calls

    def self.url()
      return "/gem/routes"
    end

    def self.all(version=v0,namespace="",auth_token)

      # ActiveRecord::Base.logger = Logger.new(STDOUT)

      endpoints = MachineShop.gem_get(url+"/#{version}/#{namespace}",auth_token)

      endpoints=endpoints.as_json
      endpoints = endpoints["#{version}"]["api"]

      if Util.db_connected?
        endpoints.each do |endpoint|
          apiend = ApiEndpoint.find_or_initialize_by(verb: endpoint['verb'], endpoint:endpoint['endpoint'], auth_token: auth_token)
          # ap apiend.as_json
          apiend.save

        end

      end
    end
  end
end