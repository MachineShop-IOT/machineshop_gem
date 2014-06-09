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


describe MachineShop::Rule do

  rules=nil
 
  it "should get all the rules " do
    rules = MachineShop::Rule.all({},auth_token)
    # puts "rules haru : #{rules}"
    ap "getting rules"
    puts rules
    ap rules.as_json
    rules.should_not be_nil


  end



 
  it "should create rule" do


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

    ap "creating rule "
    createdRule = MachineShop::Rule.create(create_hash,auth_token)

ap createdRule.as_json

    createdRule.should_not be_nil

  end

  specificRule = nil
 
  it "should get rule by id" do
    # ruleById = MachineShop::Rule.retrieve(rules[0].id,auth_token)
    specificRule = MachineShop::Rule.retrieve("5395b4829818008e790000f9",auth_token)
    ap "retrieved rule"
    ap specificRule.as_json
    specificRule.should_not be_nil

  end

  it "should delete rule by" do
    # ruleById = MachineShop::Rule.retrieve(rules[0].id,auth_token)
    delete = specificRule.delete
    ap "Deleted rule"
    ap delete.as_json
    delete.should_not be_nil

  end

  it "should get get join rule conditions" do
    test_data = MachineShop::Rule.get_join_rule_conditions(auth_token)
    puts "rule comparison : #{test_data.inspect}"
    test_data.should_not be_nil

  end


  it "should get comparison rule_conditions" do
    test_data = MachineShop::Rule.get_comparison_rule_conditions(auth_token)
    ap "comparison rule condition  :"
    ap test_data.as_json
    puts test_data
    test_data.should_not be_nil

  end


  it "should get rule by device_id" do
    test_data = MachineShop::Rule.get_by_device_instance(auth_token,'52585e1d981800bab2000478')
    ap "rule by_device_instance :"
    puts test_data
    ap test_data.as_json
    test_data.should_not be_nil

  end

  it "should get deleted rule" do
    test_data = MachineShop::Rule.get_deleted(auth_token)
    puts "deleted rule : #{test_data.inspect}"
    test_data.should_not be_nil

  end
 
end