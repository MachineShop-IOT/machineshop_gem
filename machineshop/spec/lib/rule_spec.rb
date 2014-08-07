require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'admin@csr.com'
publisher_password = 'password'

MachineShop.configure do |config|
  config.db_name = "machineshop"
  config.db_username="root"
  config.db_password="root"
  config.db_host= "localhost"
  config.expiry_time= lambda{10.seconds.ago}
  #second
end

auth_token, user = MachineShop::User.authenticate(
:email => publisher_username,
:password => publisher_password
)


describe MachineShop::Rule do

  rules=nil

  it "should get all the rules " do
    rules = MachineShop::Rule.all({},auth_token)
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

    createdRule = MachineShop::Rule.create(create_hash,auth_token)
    createdRule.should_not be_nil

  end

  specificRule = nil

  it "should get rule by id" do
    specificRule = MachineShop::Rule.retrieve("5395b4829818008e790000f9",auth_token)
    specificRule.should_not be_nil

  end

  it "should delete rule by" do
    # ruleById = MachineShop::Rule.retrieve(rules[0].id,auth_token)
    delete = specificRule.delete
    delete.should_not be_nil

  end

  it "should get get join rule conditions" do
    test_data = MachineShop::Rule.get_join_rule_conditions(auth_token)
    test_data.should_not be_nil

  end


  it "should get comparison rule_conditions" do
    test_data = MachineShop::Rule.get_comparison_rule_conditions(auth_token)
    test_data.should_not be_nil

  end


  it "should get rule by device_id" do
    test_data = MachineShop::Rule.get_by_device_instance(auth_token,'52585e1d981800bab2000478')
    test_data.should_not be_nil

  end

  it "should get deleted rule" do
    test_data = MachineShop::Rule.get_deleted(auth_token)
    test_data.should_not be_nil

  end

end