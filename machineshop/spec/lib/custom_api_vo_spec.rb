require_relative '../spec_helper'


#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'localhost:3000/api/v0'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'publisher@csr.com'
publisher_password = 'password'


auth_token, user = MachineShop::User.authenticate(
:email => publisher_username,
:password => publisher_password
)
describe MachineShop::CustomApi do

  it "should get all the CustomApi " do
    CustomApi = MachineShop::CustomApi.all({}, auth_token)

    ap  "Listing custom apis"

    ap CustomApi
    CustomApi.should_not be_nil
  end

  specificcustom_apis = nil

  it "should create custom_apis " do

    create_hash = {
      :name=> "abcde_daefault",
      :method=> "get",
      :endpoint=> "endpoint/end12",
      :base_domain =>"localhost:3000",
      :protocol=>"http"

    }

    specificcustom_apis = MachineShop::CustomApi.create(create_hash,auth_token)

    ap "created custom_apis is"
    ap specificcustom_apis.as_json
    specificcustom_apis.should_not be_nil
  end


  retrieved_api=nil
  it "should get custom_apis by custom_apis id " do
    # ap "looking up custom_apis before:"
    # ap specificcustom_apis.as_json

    retrieved_api = MachineShop::CustomApi.retrieve(specificcustom_apis.name, auth_token)

    ap "looking up custom_apis after:"
    ap retrieved_api

    retrieved_api.should_not be_nil
  end


  it "should update the custom_apis with id " do

    update_hash = {
      :name=> "dabcd_ault",
      :method=> "delete",
      :endpoint=> "endpoint/end12",
      :base_domain =>"localhost:3000",
      :protocol=>"http"

    }

    ap "updating custom_apis with id : #{specificcustom_apis.id}"
    update = MachineShop::CustomApi.update(specificcustom_apis.name,auth_token,update_hash)
    ap update
  end
end