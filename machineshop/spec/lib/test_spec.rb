require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'

publisher_username = 'admin@csr.com'
publisher_password = 'password'


  auth_token, user = MachineShop::User.authenticate(
      :email => publisher_username,
      :password => publisher_password
  )

describe MachineShop::Device do

  device = nil

  it "should get all devices for the user" do
    element_data = MachineShop::Device.all(
        {:page => 1,
         :per_page => 10},
        auth_token)

    ap "listing all devices"
    # puts element_data
    device = element_data[0]
    device.should_not be_nil
    device.should be_kind_of MachineShop::Device
  end
end




