require_relative '../spec_helper'

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

    puts "element_data from all: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

  it "should get meter by id " do

    meter_id = element_data[0].id
ap "retrieving meter for id #{meter_id}"

    # element_data = MachineShop::Meter.retrieve(meter_id, auth_token)
    element_data = MachineShop::Meter.retrieve(meter_id, auth_token)
    puts "meter by id : #{element_data}"
    element_data.should_not be_nil
  end

  it "should get meters via a user" do

    ap "meters by user "
    element_data = user.meters

    puts "meters via user: #{element_data}"
    element_data.should_not be_nil
    element_data.should_not be_empty
  end

end