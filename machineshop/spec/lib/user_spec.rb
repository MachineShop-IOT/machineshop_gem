require_relative '../spec_helper'


#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'admin@csr.com'
publisher_password = 'password'

describe MachineShop::User do
  auth_token = nil
  user = nil

  it "should allow a user to authenticate" do
    auth_token.should be_nil
    auth_token, user = MachineShop::User.authenticate(
        :email => publisher_username,
        :password => publisher_password
    )

    ap "User Data"
    ap user.as_json
    auth_token.should_not be_nil
    user.should_not be_nil
    user.should be_kind_of MachineShop::User
  end

  it "should get all roles from a static instance" do
    element_data = MachineShop::User.all_roles(auth_token)

    ap "all_roles: "
    ap element_data.as_json
    puts element_data

    element_data.should_not be_nil
  end

  it "should get all roles from a user instance" do

    ap " here user is : "
    ap user.as_json
    element_data = user.all_roles
    element_data.should_not be_nil
  end

  it "should get a user for the user by id" do
    element_data = MachineShop::User.retrieve(user.id, auth_token)

    ap "user retrieve"
    ap element_data.as_json

    element_data.should_not be_nil
    element_data.should be_kind_of MachineShop::User
  end

end

