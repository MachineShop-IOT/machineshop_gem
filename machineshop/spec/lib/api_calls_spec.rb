require 'spec_helper'

MachineShop.api_base= 'http://machineshop.dev:3000'
auth_token = nil
instance_id = nil

describe MachineShop do
  it "should allow a user to authenticate" do
    auth_token.should be_nil
    auth_token, user = MachineShop.authenticate "admin@machineshop.com", "password"
    #puts "User Data: #{user}"
    auth_token.should_not be_nil
    user.should_not be_nil
  end

 it "should get all devices for the user" do
    element_data = MachineShop.get_devices auth_token
    puts "Element Data: #{element_data}"
    element_data.should_not be_nil
  end

  it "should create devices for the user" do
    element_data = MachineShop.create_device auth_token, "my_device", "a company", "D-vice 1000",
    "yes", "my_init_cmd", "{'init':'go'}", "/etc/foo", "$199.99",
    "some arbitrary sample data", "This device tracks position and NCAA football conference.",
    "http://someurl.com/your_image.png", "http://someurl.com/manual.pdf"
    puts "Element Data: #{element_data}"
    element_data.should_not be_nil
  end

  it "should get all device instances for the user" do
    element_data = MachineShop.get_device_instances auth_token
    puts "Device Instances: #{element_data}"
    element_data.should_not be_nil

    instance_id = element_data[0][:_id]
    puts "instance_id: #{instance_id}"
    instance_id.should_not be_nil
  end

  it "should get all reports for a device instance for the user" do
    element_data = MachineShop.get_device_instance_reports auth_token, instance_id
    puts "Device Instance Reports: #{element_data}"
    element_data.should_not be_nil
  end

  it "should get the last report for a device instance for the user" do
    element_data = MachineShop.get_device_instance_last_report auth_token, instance_id
    puts "Last Device Instance Report: #{element_data}"
    element_data.should_not be_nil
  end

end
