require_relative '../spec_helper'


#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
# MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'
MachineShop.api_base_url= 'localhost:3000/api/v1'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'abcd@customer.com'
publisher_password = 'password'

describe MachineShop::Users do
  auth_token = nil
  user = nil


it "should get the versions where user exists" do 

	versions = MachineShop::Users.check_user_versions({:email=>"publisher@csr.com", :password=>"password"})
	ap versions
end

  # it "should reset the auth_token" do
  #   reset = MachineShop::Users.new_api_key("543fa688faf3d9e82300003a","UsfxTwV5zptYgCj8pheR")
  #   ap reset
  # end
end

