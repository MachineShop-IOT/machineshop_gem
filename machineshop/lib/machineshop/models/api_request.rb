
class ApiRequest < ActiveRecord::Base
	validates :url, presence: true, uniqueness: true
	# validates: url, presence: true, uniqueness: true

	def self.cache(url,auth_token, cache_policy)
		ApiRequest.where(url: url, auth_token:auth_token).first_or_create.cache(cache_policy) do
			if block_given?
				yield
			end
		end
	end


	def cache(cache_policy)
		if new_record?
			update_attribute(:updated_at, Time.now.utc)
		end

		if updated_at < cache_policy.call.utc
			update_attribute(:updated_at, Time.now.utc)
		else
			# puts "Not expired"
			yield
		end
	end

end