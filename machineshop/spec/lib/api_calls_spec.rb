require 'spec_helper'

MachineShop.api_base= 'http://machineshop.dev:3000'

describe MachineShop do
  it "should allow a user to authenticate" do        
    MachineShop.auth_token.should be_nil  
    element_data = MachineShop.authenticate! "admin@machineshop.com", "password"
    puts "Element Data: " + element_data.to_s
    MachineShop.auth_token.should_not be_nil    
  end     
  
  it "should get all devices for the user" do
    element_data = MachineShop.get_device
    puts "Element Data: " + element_data.to_s
    element_data.should_not be_nil    
  end
  
  it "should create devices for the user" do        
    element_data = MachineShop.create_device "my_device", "a company", "D-vice 1000",
      "yes", "my_init_cmd", "{'init':'go'}", "/etc/foo", "$199.99",       
      "some arbitrary sample data", "This device tracks position and NCAA football conference.",
      "http://someurl.com/your_image.png", "http://someurl.com/manual.pdf"
    puts "Element Data: " + element_data.to_s
    element_data.should_not be_nil    
  end     
end
