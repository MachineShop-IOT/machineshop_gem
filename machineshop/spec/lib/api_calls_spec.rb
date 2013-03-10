require 'spec_helper'

Machineshop.api_base= 'http://machineshop.dev:3000'
Machineshop.auth_token= 'ssn6JsULgrjwZxCmaP9n'

describe Machineshop do
  it "should get a device" do
    element_data = Machineshop.get_device
    puts "Element Data: " + element_data.to_s
    element_data.should_not be_nil    
  end
end