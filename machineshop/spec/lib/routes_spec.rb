require_relative '../spec_helper'


#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'localhost:3000/api/v1'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'publisher@csr.com'
publisher_password = 'password'


auth_token, user = MachineShop::Users.authenticate(
:email => publisher_username,
:password => publisher_password
)
describe MachineShop::Routes do

  it "should get all the CustomApis " do
    routes = MachineShop::Routes.all({}, auth_token)

    ap  "Listing routes"

    ap routes
    routes.should_not be_nil
  end
end