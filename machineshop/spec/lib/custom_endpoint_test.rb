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

auth_token, user = MachineShop::User.authenticate(
:email => publisher_username,
:password => publisher_password
)
# ap user


describe "test custome" do
  it "should test custom endpoints " do
    rules = MachineShop.get("http://stage.services.machineshop.io/api/v0/platform/rule",auth_token)
    # rules.should_not be_nil
    expect(rules).not_to be_nil
    ap rules.as_json
  end
end




