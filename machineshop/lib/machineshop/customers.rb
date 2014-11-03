module MachineShop
	class Customers < APIResource
		include MachineShop::APIOperations::List
		include MachineShop::APIOperations::Create
		include MachineShop::APIOperations::Delete
		include MachineShop::APIOperations::Update


		def self.update(id,auth_token,params={})
			response = MachineShop.gem_put(self.url+"/#{id}", auth_token, params)
			Util.convert_to_machineshop_object(response, auth_token, self.class_name)
		end

		def self.delete(id,auth_token)
			MachineShop.gem_delete(self.url+"/#{id}", auth_token)
		end

	end
end

