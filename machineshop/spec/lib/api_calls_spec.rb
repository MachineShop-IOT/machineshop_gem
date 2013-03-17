require 'spec_helper'

MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
auth_token = nil
instance_id = nil
device = nil
user = nil

describe MachineShop do
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

    puts "all_roles: #{element_data}"
    element_data.should_not be_nil
  end

  it "should get all roles from a user instance" do
    element_data = user.all_roles

    puts "all_roles: #{element_data}"
    element_data.should_not be_nil
  end

  it "should get a user for the user by id" do
    element_data = MachineShop::User.retrieve(user.id, auth_token)

    #puts "user: #{element_data}"
    element_data.should_not be_nil
    element_data.should be_kind_of MachineShop::User
  end

  it "should get all device instances for the user" do
    element_data = user.device_instances
    #puts "Element Data: #{element_data}"
    element_data.should_not be_nil
  end

  it "should get all devices for the user" do
    element_data = MachineShop::Device.all(
    {:page => 1,
      :per_page => 10},
    auth_token)
    device = element_data[0]
    #puts "Devices: #{element_data}"
    element_data.should_not be_nil
    device.should be_kind_of MachineShop::Device
  end

  it "should get a device for the user by id" do
    element_data = MachineShop::Device.retrieve(device.id, auth_token)

    #puts "Devices: #{element_data}"
    element_data.should_not be_nil
    element_data.should be_kind_of MachineShop::Device
  end

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

#Old

# it "should get all device instances for the user" do
# element_data = MachineShop.get_device_instances auth_token
# puts "Device Instances: #{element_data}"
# element_data.should_not be_nil
#
# instance_id = element_data[0][:_id]
# puts "instance_id: #{instance_id}"
# instance_id.should_not be_nil
# end
#
# it "should get the count of reports for a device instance for the user" do
# element_data = MachineShop.get_device_instance_report_count auth_token, instance_id
# puts "Device Instance Reports: #{element_data}"
# element_data.should_not be_nil
# end
#
# it "should get all reports for a device instance for the user" do
# element_data = MachineShop.get_device_instance_reports auth_token, instance_id
# puts "Device Instance Reports: #{element_data}"
# element_data.should_not be_nil
# end
#
# it "should get the last report for a device instance for the user" do
# element_data = MachineShop.get_device_instance_last_report auth_token, instance_id
# puts "Last Device Instance Report: #{element_data}"
# element_data.should_not be_nil
# end

end
