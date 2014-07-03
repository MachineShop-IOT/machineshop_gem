module MachineShop
	class Configuration
		attr_accessor :expiry_time, :enable_caching, :db_username, :db_password, :db_name, :db_host, :base_version, :custom_endpoints_cache_time

		def initialize
			#default values
			@expiry_time=0
			@enable_caching = true
			@base_version = "v0"
			@custom_endpoints_cache_time = lambda{86400.seconds.ago}
			#default 1 day
		end
	end
end