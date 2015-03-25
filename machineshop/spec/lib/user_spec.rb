require_relative '../spec_helper'


#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
# MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'
MachineShop.api_base_url= 'localhost:3000/api/v1'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'publisher@csr.com'
publisher_password = 'password'

describe MachineShop::Users do
  auth_token = nil
  user = nil

  it "should allow a user to authenticate" do
    auth_token.should be_nil

    begin

    auth_token, user = MachineShop::Users.authenticate(
        :email => publisher_username,
        :password => publisher_password
    )
      
    rescue Exception => e
      ap "exception ------------"
      # ap e.message
      # ap e.http_status
      
    end

    ap "User Data"
    # ap user.as_json
    auth_token.should_not be_nil
    user.should_not be_nil
    # user.should be_kind_of MachineShop::Users
  end

  it "should send instruction to reset password " do
    begin
      
    reset = MachineShop::Users.password_reset({email: "niroj@bajratechnologies.com", domain: "machineshop", send_email: true})
    ap reset
    rescue Exception => e
      puts e
    end
  end

  it "should reset the password" do
    begin
      
    reset_complete = MachineShop::Users.password_reset_complete("5KexNcXpygS94T9wFF6a",{password: "new_password", password_confirmation: "new_password"})
    ap reset_complete
    rescue Exception => e
      puts e
    end
  end


  # tmpfile = "abc.png"

  # logo = File.open(tmpfile, "r")

  # it "should create logo" do 
  #   logo = MachineShop::Users.create_user_logo(user.id,{logo: logo}, auth_token)
  # end


  it "should get all roles from a static instance" do
    element_data = MachineShop::Users.all_roles(auth_token)

    ap "all_roles: "
    # ap element_data.as_json
    puts element_data

    element_data.should_not be_nil
  end

  it "should get all roles from a user instance" do

    ap " here user is : "
    # ap user.as_json
    element_data = user.all_roles
    element_data.should_not be_nil
  end

  it "should get a user for the user by id" do
    element_data = MachineShop::Users.retrieve(user.id, auth_token)

    ap "user retrieve"
    # ap element_data.as_json

    element_data.should_not be_nil
    element_data.should be_kind_of MachineShop::Users
  end

end

