require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'

publisher_username = 'admin@csr.com'
publisher_password = 'password'

MachineShop.configure do |config|
  config.db_name = "machineshop"
  config.db_username="root"
  config.db_password="root"
  config.db_host= "localhost"
  config.expiry_time= lambda{120.seconds.ago}
  #second
end

# auth_token, user = MachineShop::User.authenticate(
# :email => publisher_username,
# :password => publisher_password
# )

auth_token="2jzZmcHWLZyghsxcB16E"

describe MachineShop::EndPoints do


  it "should call get method " do 
    # test = MachineShop::get("/gem/routes/v0",auth_token)
      test = MachineShop::EndPoints.all("v0",auth_token)

  # ap test.as_json

  end

  # it "should get all the endpoints" do

  #   element_data = MachineShop::EndPoints.all("v0",auth_token)
  #   # element_data = MachineShop::EndPoints.all({:namespace=>"secm"},auth_token)

  #   ap "listing all endpoints"
  #   puts element_data.as_json
  # end
end