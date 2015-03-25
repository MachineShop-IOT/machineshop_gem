class ApiEndpoint < ActiveRecord::Base
	validates :endpoint, presence: true
	validates :verb, presence: true
	# validates: url, presence: true, uniqueness: true

	validates_uniqueness_of :endpoint, :scope=> [:verb,:auth_token]
	# validates_uniqueness_of :user_id, :scope => [:entity_id, :post_id]
end