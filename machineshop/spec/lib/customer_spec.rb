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
describe MachineShop::Customer do

  it "should get all the customers " do
    customers = MachineShop::Customer.all({}, auth_token)

    customers.should_not be_nil
  end

  specificCustomer = nil
  it "should create customer " do

    specificCustomer = MachineShop::Customer.create({:email=>"bajratests@bajratechnologies.com",
      :password=>'password',
      :notification_method=>'sms',
      :first_name=>'niroj',:last_name=>'sapkota',
      :phone_number=>'98989898989',
      :company_name=>'technology co'

    },auth_token)

    specificCustomer.should_not be_nil
  end


  retrieved_cust=nil
  it "should get customer by customer id " do
    retrieved_cust = MachineShop::Customer.retrieve(specificCustomer.id, auth_token)

    retrieved_cust.should_not be_nil
  end


  it "should update the customer with id " do
    update = MachineShop::Customer.update(specificCustomer.id,auth_token,{:notification_method => 'email',:first_name=>'testJohn'})
    update.should_not be_nil
  end


  it "should update the customer from the retrieved obj id " do
    update = retrieved_cust.update({:notification_method => 'email'})
  end

  it "should delete customer with id " do
    delete = specificCustomer.delete
    delete.http_code.should eq 200
  end
end