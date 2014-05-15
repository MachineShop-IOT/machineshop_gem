module MachineShop
	class Configuration
		attr_accessor :expiry_time, :enable_caching, :db_username, :db_password, :db_name, :db_host

		def initialize
			#default values
			@expiry_time=6
			@enable_caching = true		
		end
	end
end