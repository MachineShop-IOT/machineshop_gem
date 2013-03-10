require 'spec_helper'

MachineShop.api_base= 'http://machineshop.dev:3000'
MachineShop.auth_token= 'ssn6JsULgrjwZxCmaP9n'

describe MachineShop do
  it "should get a device" do
    element_data = MachineShop.get_device
    puts "Element Data: " + element_data.to_s
    element_data.should_not be_nil    
  end
end
