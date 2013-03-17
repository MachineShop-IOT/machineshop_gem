require 'spec_helper'

MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'

describe MachineShop::User do
  auth_token = nil
  user = nil

  it "should allow a user to authenticate" do
    auth_token.should be_nil
    auth_token, user = MachineShop::User.authenticate(
    :email => "admin@machineshop.com",
    :password => "password"
    )

    #puts "User Data: #{user}"
    auth_token.should_not be_nil
    user.should_not be_nil
    user.should be_kind_of MachineShop::User
  end

  it "should get all roles from a static instance" do
    element_data = MachineShop::User.all_roles(auth_token)

    #puts "all_roles: #{element_data}"
    element_data.should_not be_nil
  end

  it "should get all roles from a user instance" do
    element_data = user.all_roles

    #puts "all_roles: #{element_data}"
    element_data.should_not be_nil
  end

  it "should get a user for the user by id" do
    element_data = MachineShop::User.retrieve(user.id, auth_token)

    #puts "user: #{element_data}"
    element_data.should_not be_nil
    element_data.should be_kind_of MachineShop::User
  end

end

describe MachineShop::Device do

  auth_token, user = MachineShop::User.authenticate(
  :email => "admin@machineshop.com",
  :password => "password"
  )

  device = nil

  it "should create devices for the user" do
    element_data = MachineShop::Device.create(
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

    #puts "Element Data: #{element_data}"
    #puts "element_data.class: #{element_data.class}"

    element_data.should_not be_nil
    element_data.should be_kind_of MachineShop::Device
  end

  it "should get all devices for the user" do
    element_data = MachineShop::Device.all(
    {:page => 1,
      :per_page => 10},
    auth_token)
    device = element_data[0]
    #puts "Devices: #{element_data}"
    device.should_not be_nil
    device.should be_kind_of MachineShop::Device
  end

  it "should get a device for the user by id" do
    element_data = MachineShop::Device.retrieve(device.id, auth_token)

    #puts "Devices: #{element_data}"
    element_data.should_not be_nil
    element_data.should be_kind_of MachineShop::Device
  end

  it "should get a device for the user by name" do
    element_data = MachineShop::Device.all(
    {
      :name => device.name
    },
    auth_token)

    #puts "Devices: #{element_data}"
    element_data.should_not be_nil
    element_data.should_not be_empty
  end

# it "should get a device's payload_fields" do
# element_data = device.payload_fields
# element_data.class
# puts "payload_fields: #{element_data}"
# puts "element_data.class: #{element_data.class}"
# element_data.should_not be_nil
#
# end

end

describe MachineShop::DeviceInstance do

  auth_token, user = MachineShop::User.authenticate(
  :email => "admin@machineshop.com",
  :password => "password"
  )

  device = nil
  device_instance = nil

  it "should create a device instance for the user" do
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

    #puts "device: #{device.inspect}"

    # Now create an instance
    device_instance = device.create_instance(
    {
      :name => "My little instance",
      :active => "yes"
    }
    )

    #puts "Device Instance: #{device_instance.inspect}"
    device_instance.should_not be_nil
    device_instance.should be_kind_of MachineShop::DeviceInstance
  end

  it "should get a device instance for a device" do
    element_data = device.instances

    #puts "Device Instances: #{element_data}"
    element_data.should_not be_nil
    element_data.should_not be_empty
  end

  it "should get all device instances" do
    element_data = MachineShop::DeviceInstance.all({}, auth_token)

    #puts "Device Instances: #{element_data}"

    device_instance = element_data[0]
    element_data.should_not be_nil
    element_data.should_not be_empty

    device_instance.should be_kind_of MachineShop::DeviceInstance
  end

  it "should get a device instance by id" do
    element_data = MachineShop::DeviceInstance.retrieve(device_instance.id, auth_token)

    #puts "Device Instance: #{element_data}"

    element_data.should_not be_nil
    element_data.should be_kind_of MachineShop::DeviceInstance
  end

  it "should get a device instance by name" do
    element_data = MachineShop::DeviceInstance.all({:name => device_instance.name}, auth_token)

    #puts "Device Instance: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

end

describe MachineShop::Mapping do

  auth_token, user = MachineShop::User.authenticate(
  :email => "admin@machineshop.com",
  :password => "password"
  )

  it "should get a geocoded address" do
    element_data = MachineShop::Mapping.geocode(
    {
      :address => "1600 Amphitheatre Parkway, Mountain View, CA",
      :sensor => "false"
    },
    auth_token)

    #puts "GEO: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

  it "should get directions" do
    element_data = MachineShop::Mapping.directions(
    {
      :origin => "Denver",
      :destination => "Boston",
      :sensor => "false"
    },
    auth_token)

    #puts "GEO: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

  it "should get distance" do
    element_data = MachineShop::Mapping.distance(
    {
      :origins => "Vancouver BC",
      :destinations => "San Francisco",
      :mode => "bicycling",
      :language => "fr-FR",
      :sensor => "false"
    },
    auth_token)

    #puts "GEO: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

end

describe MachineShop::Meter do

  auth_token, user = MachineShop::User.authenticate(
  :email => "admin@machineshop.com",
  :password => "password"
  )

end

describe MachineShop::Report do

  auth_token, user = MachineShop::User.authenticate(
  :email => "admin@machineshop.com",
  :password => "password"
  )

end

describe MachineShop::Rule do

  auth_token, user = MachineShop::User.authenticate(
  :email => "admin@machineshop.com",
  :password => "password"
  )

end

describe MachineShop::Util do

  auth_token, user = MachineShop::User.authenticate(
  :email => "admin@machineshop.com",
  :password => "password"
  )

end
