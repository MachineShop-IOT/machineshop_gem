require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'admin@csr.com'
publisher_password = 'password'


  auth_token, user = MachineShop::User.authenticate(
      :email => publisher_username,
      :password => publisher_password
  )

  element_data=nil
describe MachineShop::Meter do

  it "should get all meter data" do
    element_data = MachineShop::Meter.all({}, auth_token)

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

  it "should get meter by id " do

    meter_id = element_data[0].id
    element_data = MachineShop::Meter.retrieve(meter_id, auth_token)
    element_data.should_not be_nil
  end

  it "should get meters via a user" do

    element_data = user.meters

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

end