module MachineShop
	class Customer < APIResource
		include MachineShop::APIOperations::List
		include MachineShop::APIOperations::Create
		include MachineShop::APIOperations::Delete
		include MachineShop::APIOperations::Update


		def self.update(id,auth_token,params={})
			response = MachineShop.put(self.url+"/#{id}", auth_token, params)
			Util.convert_to_machineshop_object(response, auth_token, self.class_name)
		end
	end
end

