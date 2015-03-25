require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
# MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'
MachineShop.api_base_url= 'http://localhost:3000/api/v1'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'publisher@csr.com'
publisher_password = 'password'


auth_token, user = MachineShop::Users.authenticate(
:email => publisher_username,
:password => publisher_password
)

reports=nil

describe MachineShop::Reports do


  # it "should create report" do

  #   report_json = {
  #     :data_source_id=>"asdfds",
  #     :device_datetime=> "2014-8-24 15:22:27",
  #     :raw_data=> "video on",
  #     :payload=> {
  #       :video=> "1",
  #       :test_new=> "Demo test 10"
  #     }

  #   }

  #   ret = MachineShop::Reports.create(report_json, auth_token)
  #   ap ret

  # end

  it "should get all report data" do
    element_data = MachineShop::Reports.all({}, auth_token)
    reports=element_data
    puts "element_data: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end



  it "should get report of specific device" do
    element_data = MachineShop::Reports.all(
    ({
      :data_source_id => '543e1437faf3d9695900001d',
      # :per_page=>'1000',
      # :created_at_between=>'2013-11-04T00:00:00_2014-03-19T17:02:00'
    }), auth_token)

    puts "element data of 543e1437faf3d9695900001d #{element_data} "

    element_data.should_not be_nil
  end

  
end