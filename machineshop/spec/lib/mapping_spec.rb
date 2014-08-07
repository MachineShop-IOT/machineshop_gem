require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'admin@csr.com'
publisher_password = 'password'


  auth_token, user = MachineShop::User.authenticate(
      :email => publisher_username,
      :password => publisher_password
  )

describe MachineShop::Mapping do

   it "should get a geocoded address" do
    element_data = MachineShop::Mapping.geocode(
        {
            :address => "1600 Amphitheatre Parkway, Mountain View, CA",
            :sensor => "false"
        },
        auth_token)

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
    element_data.should_not be_nil
    element_data.should_not be_empty
  end

end