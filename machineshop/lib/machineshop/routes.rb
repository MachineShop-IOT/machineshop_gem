#User Routes
module MachineShop

	class Routes < APIResource

		def self.authorized_routes_json(auth_token)      
	      auth_routes = MachineShop.gem_get("/platform/authorized_routes/", auth_token, nil)
	    end

		private
		def self.url
			'/platform/routes?flag=portal'
		end


	end


end

