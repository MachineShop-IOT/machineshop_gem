require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'publisher@csr.com'
publisher_password = 'password'


  auth_token, user = MachineShop::User.authenticate(
      :email => publisher_username,
      :password => publisher_password
  )


describe MachineShop::Rule do

  rules=nil
 
  it "should get all the rules " do
    rules = MachineShop::Rule.all({},auth_token)
    # puts "rules haru : #{rules}"
    rules.should_not be_nil


  end



 
  it "should create rule" do


 create_hash = {
      :devices=>"52585e1d981800bab2000479",
      :device_instances=>{},
      :rule=>{
          :active=>true,
          :description=>"bajratest",
          :condition=>{
              :type=>"and_rule_condition",
              :rule_conditions=>{

                  :property=>"var",
                  :value=>"30",
                  :type=>"equal_rule_condition"

              }
          },
          :then_actions=>{
              :priority=>"1",
              :send_to=>"abc@me.com",
              :type=>"email_rule_action"
          }
      }
  }

    createdRule = MachineShop::Rule.create(create_hash,auth_token)

    createdRule.should_not be_nil

  end
 
  it "should get rule by id" do
    # ruleById = MachineShop::Rule.retrieve(rules[0].id,auth_token)
    ruleById = MachineShop::Rule.retrieve("5332c3e2385f7f7ed800001d",auth_token)
    # puts "rule by id  : #{ruleById}"
    ruleById.should_not be_nil

  end

  it "should get get join rule conditions" do
    test_data = MachineShop::Rule.get_join_rule_conditions(auth_token)
    puts "rule comparison : #{test_data.inspect}"
    test_data.should_not be_nil

  end


  it "should get comparison rule_conditions" do
    test_data = MachineShop::Rule.get_comparison_rule_conditions(auth_token)
    puts "comparison rule condition  : #{test_data.inspect}"
    test_data.should_not be_nil

  end


  it "should get rule by device_id" do
    test_data = MachineShop::Rule.get_by_device_instance(auth_token,'52585e1d981800bab2000478')
    puts "rule by_device_instance : #{test_data.inspect}"
    test_data.should_not be_nil

  end

  it "should get deleted rule" do
    test_data = MachineShop::Rule.get_deleted(auth_token)
    puts "deleted rule : #{test_data.inspect}"
    test_data.should_not be_nil

  end
 
end