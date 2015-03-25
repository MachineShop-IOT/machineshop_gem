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
      ap e.message
    end

    auth_token.should_not be_nil
    user.should_not be_nil
    user.should be_kind_of MachineShop::Users
  end



  it "should create logo" do 
  tmpfile = "abc.png"
  logo = File.open(tmpfile, "r")
  logoHash = {logo: logo}
    begin
    logoupload = MachineShop::Users.create_user_logo(user.id,logoHash, auth_token)
      
    rescue Exception => e
      ap e
    end

    ap logoupload
  end
end

