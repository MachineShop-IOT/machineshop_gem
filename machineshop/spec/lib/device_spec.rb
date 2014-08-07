require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'

#publisher_username = 'publisher@machineshop.com'
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

describe MachineShop::Device do

  device = nil

  it "should get all devices for the user" do
    element_data = MachineShop::Device.all(
        {:page => 1,
         :per_page => 10},
        auth_token)

    device = element_data[0]
    device.should_not be_nil
    device.should be_kind_of MachineShop::Device
  end

specificDevice = nil


  it "should get a device for the user by id" do
    specificDevice = MachineShop::Device.retrieve(device[:id], auth_token)

    specificDevice.should_not be_nil
    specificDevice.should be_kind_of MachineShop::Device
  end



  it "should delete device" do
    delete = specificDevice.delete

    delete.http_code.should eq 200
  end


  it "should get a device for the user by name" do
    element_data = MachineShop::Device.all(
        {
            :name => device.name
        },
        auth_token)

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

end

describe MachineShop::DeviceInstance do

  device = nil
  device_instance = nil

  it "should create a device for the user" do
    # First create a device to use
    device = MachineShop::Device.create(
        {
            :name =>  "my_device",
            :type => "Test",
            :manufacturer =>  "a company",
            :model =>  "D-vice 1000",
            :active =>  "yes",
            :init_cmd =>  "my_init_cmd",
            :init_params =>  "{'init':'go'}",
            :exe_path =>  "/etc/foo",
            :unit_price =>  "$199.99",
            :sample_data =>  "some arbitrary sample data",
            :long_description =>  "This device tracks position and NCAA football conference.",
            :image_url =>  "http://someurl.com/your_image.png",
            :manual_url =>  "http://someurl.com/manual.pdf"
        },
        auth_token)


    # Now create an instance
    device_instance = device.create_instance(
        {
            :name => "My little instance",
            :active => "yes"
        }
    )

    device_instance.should_not be_nil
    device_instance.should be_kind_of MachineShop::DeviceInstance
  end


  it "should get device instances" do
    element_data = MachineShop::DeviceInstance.all({}, auth_token)

    device_instance = element_data[0]
    element_data.should_not be_nil
    element_data.should_not be_empty

    device_instance.should be_kind_of MachineShop::DeviceInstance
  end


  it "should get a device instance by id" do
    element_data = MachineShop::DeviceInstance.retrieve("5395835f385f7f53ec000160", auth_token)

    element_data.should_not be_nil
    element_data.should be_kind_of MachineShop::DeviceInstance
  end

  it "should get a device instance by name" do
    element_data = MachineShop::DeviceInstance.all({:name => device_instance.name}, auth_token)

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

  it "should get all devices via a user" do
    element_data = user.device_instances

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

  it "should get all devices via a user with a filter" do
    element_data = user.device_instances({:name => device_instance.name})

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

end
