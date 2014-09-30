#User Routes
module MachineShop
	class Routes < APIResource
		include MachineShop::APIOperations::List

		private
		def self.url
			'/platform/routes?flag=portal'
		end


	end


end

