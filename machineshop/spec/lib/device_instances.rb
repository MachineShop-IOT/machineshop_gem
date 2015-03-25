require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'admin@csr.com'
publisher_password = 'password'


  auth_token ="fghjkljkl"
  # , user = MachineShop::User.authenticate(
  #     :email => publisher_username,
  #     :password => publisher_password
  # )

describe MachineShop::DeviceInstance do

 
specificDevice = nil

device = nil

  it "should get all devices for the user" do
    element_data = MachineShop::DeviceInstance.all(
        {:page => 1,
         :per_page => 10},
        auth_token)

    ap "listing all devices"
    puts element_data
    device = element_data[0]
    device.should_not be_nil
    device.should be_kind_of MachineShop::Device
  end




  it "should get a device for the user by id" do
    specificDevice = MachineShop::Device.retrieve(device.id, auth_token)

    ap "Device by id"
    ap specificDevice.as_json
    specificDevice.should_not be_nil
    specificDevice.should be_kind_of MachineShop::Device
  end


  it "should create device instance " do 
    device_instance = specificDevice.create_instance(
    {
        :name => "My little instance",
        :active => "yes"
    }


)

    ap "creating instance"
    ap device_instance.as_json
  end



  it "should get instances of device device" do
    ins = specificDevice.instances

    ap "ins "
    ap ins.as_json
  end

end
