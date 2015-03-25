module MachineShop
	class Monitor < APIResource
		include MachineShop::APIOperations::List

		def self.url()
			"/platform/data/#{CGI.escape(class_name.underscore)}"
			# ret
		end

		def self.total_reports_per_day(start_date, end_date, auth_token)
			MachineShop.gem_get(data_url+"/total_reports_per_day/#{start_date}/#{end_date}",auth_token)
		end

		#for v0
		def self.reports_per_device_instance_per_day(start_date, end_date, auth_token)
			MachineShop.gem_get(data_url+"/reports_per_device_instance_per_day/#{start_date}/#{end_date}",auth_token)
		end

		#for v1
		def self.reports_per_data_source_per_day(start_date, end_date, auth_token)
			MachineShop.gem_get(data_url+"/reports_per_data_source_per_day/#{start_date}/#{end_date}",auth_token)
		end

		def self.api_requests_per_day(start_date, end_date, auth_token)
			MachineShop.gem_get(data_url+"/api_requests_per_day/#{start_date}/#{end_date}",auth_token)
		end

		def self.rule_last_run_summary(auth_token)
			MachineShop.gem_get(data_url+"/rule_last_run_summary",auth_token)
		end

		private
		def self.data_url
			"/platform/data"
		end

	end

end