
class ApiRequest < ActiveRecord::Base
	validates :url, presence: true, uniqueness: true
	# validates: url, presence: true, uniqueness: true

	def self.cache(url,auth_token, cache_policy)
		find_or_initialize_by(url: url, auth_token:auth_token).cache(cache_policy) do
			if block_given?
				yield
			end
		end
	end


	def cache(cache_policy)
		# puts "updated_at -- #{updated_at}    #{cache_policy.call.utc}  now=>  #{cache_policy.call}"
		if new_record?
			update_attributes(updated_at: Time.now.utc)
		end

		if updated_at < cache_policy.call.utc
			update_attributes(updated_at: Time.now.utc)
		else
			# puts "Not expired"
			yield
		end
	end

end