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

    puts "customers are #{customers}"

    #puts "first customer is : #{customers[0][:id]}"

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

    ap "created customer is"
    ap specificCustomer.as_json
    specificCustomer.should_not be_nil
  end


 retrieved_cust=nil
  it "should get customer by customer id " do
    ap "looking up customer before:"
    ap specificCustomer.as_json
    
    retrieved_cust = MachineShop::Customer.retrieve(specificCustomer.id, auth_token)
    
    ap "looking up customer after:"
    ap retrieved_cust.as_json
    
    retrieved_cust.should_not be_nil
  end


  it "should update the customer with id " do

    ap "updating customer with id : #{specificCustomer.id}"
    update = MachineShop::Customer.update(specificCustomer.id,auth_token,{:notification_method => 'email',:first_name=>'testJohn'})
    ap update.as_json
  end


  it "should update the customer from the retrieved obj id " do
    ap "updating customer from the retrieved obj id : #{specificCustomer.id}"

    update = retrieved_cust.update({:notification_method => 'email'})
    ap update.as_json
  end
  
  #success test

  it "should delete customer with id " do

    #puts
    puts "deleting customer with id : #{specificCustomer.id}"

    delete = specificCustomer.delete
    #delete = MachineShop::Customer.delete(customers[0].id,auth_token)
    puts "delete #{delete}"
    delete.http_code.should eq 200
  end
end