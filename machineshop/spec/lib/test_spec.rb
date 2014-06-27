require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'

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

# auth_token, user = MachineShop::User.authenticate(
# :email => publisher_username,
# :password => publisher_password
# )
# ap user

auth_token="2jzZmcHWLZyghsxcB16E"


describe MachineShop::Device do

  device = nil

  it "should get a geocoded address" do
    element_data = MachineShop::Mapping.geocode(
    {
      :latlng => "40.714224,-73.961452",
      # :address => "1600 Amphitheatre Parkway, Mountain View, CA",
      # :sensor => "false"
    },
    auth_token)

    #puts "GEO: #{element_data}"
    # ap element_data.as_json

    # MachineShop::Device.url

    element_data.should_not be_nil
    element_data.should_not be_empty
  end


end




