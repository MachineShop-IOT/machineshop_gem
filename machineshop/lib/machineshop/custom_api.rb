#User Defined API for V0
module MachineShop
	class CustomApi < APIResource
		include MachineShop::APIOperations::List
		include MachineShop::APIOperations::Create
		# include MachineShop::APIOperations::Delete
		# include MachineShop::APIOperations::Update


		def self.update(name,auth_token,params={})
			response = MachineShop.gem_put(self.url+"/#{name}", auth_token, params)
			Util.convert_to_machineshop_object(response, auth_token, self.class_name)
		end

		def self.delete(name,auth_token)
			response = MachineShop.gem_delete(self.url+"/#{name}", auth_token, {})
		end
	end

	def self.url
		"/platform/custom"
	end
end

