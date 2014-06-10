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

  reports=nil
describe MachineShop::Report do

    it "should get all report data" do
    element_data = MachineShop::Report.all({}, auth_token)
reports=element_data
    puts "element_data: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end



  it "should get report of specific device" do
    element_data = MachineShop::Report.all(
        ({:device_instance_id => '538461dc9818006e0900005e',
          :per_page=>'1000',
          #:created_at_between=>'2013-11-04T00:00:00_2014-03-19T17:02:00'
        }), auth_token)

    puts "element data of f00e5981800ad58000006 #{element_data} "

    element_data.should_not be_nil
  end

  it "should get specific report by id" do
    specific_report_id=reports[0].id
    element_data = MachineShop::Report.retrieve("5384800dff7346390c000001",auth_token)

    puts "report specific #{element_data} "

    element_data.should_not be_nil
  end


end