require_relative '../spec_helper'


#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'localhost:3000/api/v1'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'publisher@csr.com'
publisher_password = 'password'


auth_token, user = MachineShop::Users.authenticate(
:email => publisher_username,
:password => publisher_password
)

ApiProxies = nil
describe MachineShop::ApiProxies do

  it "should get all the ApiProxies " do
    ApiProxies = MachineShop::ApiProxies.all({}, auth_token)

    ap  "Listing custom apis"

    ap ApiProxies
    ApiProxies.should_not be_nil
  end


  it "should delete custom api " do
    ap "deleting #{ApiProxies[0].id}"
    delete = MachineShop::ApiProxies.delete(ApiProxies[0].id,auth_token)
    ap delete
    expect(delete[:http_code]).to equal(200)

  end



  specific_api_proxies = nil

  it "should create api_proxies " do

    create_hash = {
      :name=> "abcde_daefault",
      :method=> "get",
      :endpoint=> "endpoint/end12",
      :base_domain =>"localhost:3000",
      :protocol=>"http",
      :signature=>"singature1235"

    }

    specific_api_proxies = MachineShop::ApiProxies.create(create_hash,auth_token)

    ap "created api_proxies is"
    ap specific_api_proxies.as_json
    specific_api_proxies.should_not be_nil
  end


  retrieved_api=nil
  it "should get api_proxies by api_proxies id " do
    # ap "looking up api_proxies before:"
    # ap specific_api_proxies.as_json

    retrieved_api = MachineShop::ApiProxies.retrieve(specific_api_proxies.name, auth_token)

    ap "looking up api_proxies after:"
    ap retrieved_api

    retrieved_api.should_not be_nil
  end


  it "should update the api_proxies with id " do

    update_hash = {
      :name=> "dabcd_ault",
      :method=> "delete",
      :endpoint=> "endpoint/end12",
      :base_domain =>"localhost:3000",
      :protocol=>"http"

    }

    ap "updating api_proxies with id : #{specific_api_proxies.id}"
    update = MachineShop::ApiProxies.update(specific_api_proxies.id,auth_token,update_hash)
    ap update
  end
end