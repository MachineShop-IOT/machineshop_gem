#User Routes
module MachineShop

	class Routes < APIResource

		def self.authorized_routes_json(auth_token)      
	      auth_routes = MachineShop.gem_get("/platform/authorized_routes/", auth_token, nil)
	    end

	    def self.single_authorized_route(id,auth_token)      
	      auth_routes = MachineShop.gem_get("/platform/authorized_routes/"+id, auth_token, nil)
	    end

	    def self.single_authorized_route_put(id,json,auth_token)      
	      auth_routes = MachineShop.gem_put("/platform/authorized_routes/"+id, auth_token, json)
	    end

		private
		def self.url
			'/platform/routes?flag=portal'
		end


	end


end

