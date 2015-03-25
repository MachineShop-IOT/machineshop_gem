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

auth_token, user = MachineShop::User.authenticate(
:email => publisher_username,
:password => publisher_password
)
# ap user


describe "test custome" do

  it "should call get method " do
    test = MachineShop.get("documents",auth_token,"1234")
  end

  it "should call post method " do

    create_hash = {
      :devices=>["52585e1d981800bab2000479"],
      :device_instances=>[],
      :rule=>{
        :active=>true,
        :description=>"bajratest",
        :condition=>{
          :type=>"and_rule_condition",
          :rule_conditions=>[{

            :property=>"var",
            :value=>"30",
            :type=>"equal_rule_condition"

          }]
        },
        :then_actions=>[{
          :priority=>"1",
          :send_to=>"abc@me.com",
          :type=>"email_rule_action"
        }]
      }
    }

    # ap "creating rule "
    createdRule = MachineShop.post("rules",auth_token,create_hash)

  end




  it "should call put method " do
    url = "/platform/customer/533009a0981800984500001e"
    update_hash = {:notification_method => 'sms',:first_name=>'from_custom'}

    MachineShop.put("rules",auth_token,"533009a0981800984500001e",update_hash)
  end


  it "should call delete method " do
    MachineShop.delete("platform",auth_token,"53b52a8e9818005d8d000019")
  end

end