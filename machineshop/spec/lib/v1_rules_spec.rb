require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
# MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'
MachineShop.api_base_url= 'localhost:3000/api/v1'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'publisher@csr.com'
publisher_password = 'password'

MachineShop.configure do |config|
  config.db_name = "machineshop"
  config.db_username="root"
  config.db_password="root"
  config.db_host= "localhost"
  config.expiry_time= lambda{10.seconds.ago}
   #second
end

  auth_token, user = MachineShop::Users.authenticate(
      :email => publisher_username,
      :password => publisher_password
  )


describe MachineShop::Rules do

  rules=nil
 
  it "should get all the rules " do
    rules = MachineShop::Rules.all({},auth_token)
    # puts "rules haru : #{rules}"
    # ap "getting rules"
    # ap rules.as_json
    rules.should_not be_nil


  end



 
  it "should create rule" do

 create_hash = {
      :data_source_types=>["52585e1d981800bab2000479"],
      :data_sources=>["5417d6effaf3d9e6b6000002","5416b294faf3d9ae140000ae"],
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
    createdRule = MachineShop::Rules.create(create_hash,auth_token)

    ap "createdRule"
    ap createdRule

# ap createdRule.as_json

    createdRule.should_not be_nil

  end

  specificRule = nil
 
 
end