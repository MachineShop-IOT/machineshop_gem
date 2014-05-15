require 'spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'admin@csr.com'
publisher_password = 'password'



describe "#expiry_time" do
  it "default value is 6" do
    MachineShop::Configuration.new.expiry_time =23
    # puts "original value is #{MachineShop::Configuration.expiry_time}"
  end
end


describe "#expiry_time=" do
  it "can set value" do

    MachineShop.configure do |config|
      config.expiry_time = 10
      config.enable_caching = false
      config.db_username="root"
      config.db_password="root"
      config.db_name="machineshop"
    end
    config = MachineShop.configuration

    
    config.expiry_time = 7
    expect(config.expiry_time).to eq(7)
    puts config.expiry_time
  end

  it "stores into database" do
    # Database.new
    db = MachineShop::Database.new
    MachineShop::Database.insert('endpoints',"/user/devices/id2")


  end
end



=begin

describe "Rubysession" do
  it "should store session " do
    session[:user_id] = "hello"
  end
end

describe MachineShop::User do
  auth_token = nil
  user = nil

  it "should allow a user to authenticate" do
    auth_token.should be_nil
    auth_token, user = MachineShop::User.authenticate(
        :email => publisher_username,
        :password => publisher_password
    )

    puts "User Data: #{user}"
    auth_token.should_not be_nil
    user.should_not be_nil
    user.should be_kind_of MachineShop::User
  end

  it "should get all roles from a static instance" do
    element_data = MachineShop::User.all_roles(auth_token)

    puts "all_roles: #{element_data}"
    element_data.should_not be_nil
  end

  it "should get all roles from a user instance" do

    puts " here user is : #{user}"
    element_data = user.all_roles

    #puts "all_roles: #{element_data}"
    element_data.should_not be_nil
  end

  it "should get a user for the user by id" do
    element_data = MachineShop::User.retrieve(user.id, auth_token)

    #puts "user: #{element_data}"
    element_data.should_not be_nil
    element_data.should be_kind_of MachineShop::User
  end

end

describe MachineShop::Device do

  auth_token, user = MachineShop::User.authenticate(
      :email => publisher_username,
      :password => publisher_password
  )

  device = nil

  it "should create devices for the user" do
    element_data = MachineShop::Device.create(
        {
            :name =>  "my_device",
            :type => "Test",
            :manufacturer =>  "a company",
            :model =>  "D-vice 1000",
            :active =>  "yes",
            :init_cmd =>  "my_init_cmd",
            :init_params =>  "{'init':'go'}",
            :exe_path =>  "/etc/foo",
            :unit_price =>  "$199.99",
            :sample_data =>  "some arbitrary sample data",
            :long_description =>  "This device tracks position and NCAA football conference.",
            :image_url =>  "http://someurl.com/your_image.png",
            :manual_url =>  "http://someurl.com/manual.pdf"
        },
        auth_token)

    puts "Element Data: #{element_data}"
    puts "element_data.class: #{element_data.class}"

    element_data.should_not be_nil
    element_data.should be_kind_of MachineShop::Device
  end

  it "should get all devices for the user" do
    element_data = MachineShop::Device.all(
        {:page => 1,
         :per_page => 10},
        auth_token)
    device = element_data[0]
    #puts "Devices: #{element_data}"
    device.should_not be_nil
    device.should be_kind_of MachineShop::Device
  end

  it "should get a device for the user by id" do
    element_data = MachineShop::Device.retrieve(device.id, auth_token)

    #puts "Devices: #{element_data}"
    element_data.should_not be_nil
    element_data.should be_kind_of MachineShop::Device
  end

  it "should get a device for the user by name" do
    element_data = MachineShop::Device.all(
        {
            :name => device.name
        },
        auth_token)

    #puts "Devices: #{element_data}"
    element_data.should_not be_nil
    element_data.should_not be_empty
  end

# it "should get a device's payload_fields" do
# element_data = device.payload_fields
# element_data.class
# puts "payload_fields: #{element_data}"
# puts "element_data.class: #{element_data.class}"
# element_data.should_not be_nil
#
# end

end

describe MachineShop::DeviceInstance do

  auth_token, user = MachineShop::User.authenticate(
      :email => publisher_username,
      :password => publisher_password
  )

  device = nil
  device_instance = nil

  it "should create a device instance for the user" do
    # First create a device to use
    device = MachineShop::Device.create(
        {
            :name =>  "my_device",
            :type => "Test",
            :manufacturer =>  "a company",
            :model =>  "D-vice 1000",
            :active =>  "yes",
            :init_cmd =>  "my_init_cmd",
            :init_params =>  "{'init':'go'}",
            :exe_path =>  "/etc/foo",
            :unit_price =>  "$199.99",
            :sample_data =>  "some arbitrary sample data",
            :long_description =>  "This device tracks position and NCAA football conference.",
            :image_url =>  "http://someurl.com/your_image.png",
            :manual_url =>  "http://someurl.com/manual.pdf"
        },
        auth_token)

    puts "device: #{device.inspect}"

    # Now create an instance
    device_instance = device.create_instance(
        {
            :name => "My little instance",
            :active => "yes"
        }
    )

    #puts "Device Instance: #{device_instance.inspect}"
    device_instance.should_not be_nil
    device_instance.should be_kind_of MachineShop::DeviceInstance
  end

  it "should get a device instance for a device" do
    element_data = device.instances

    #puts "Device Instances: #{element_data}"
    element_data.should_not be_nil
    element_data.should_not be_empty
  end

  it "should get all device instances" do
    element_data = MachineShop::DeviceInstance.all({}, auth_token)

    #puts "Device Instances: #{element_data}"

    device_instance = element_data[0]
    element_data.should_not be_nil
    element_data.should_not be_empty

    device_instance.should be_kind_of MachineShop::DeviceInstance
  end

  it "should get a device instance by id" do
    element_data = MachineShop::DeviceInstance.retrieve(device_instance.id, auth_token)

    #puts "Device Instance: #{element_data}"

    element_data.should_not be_nil
    element_data.should be_kind_of MachineShop::DeviceInstance
  end

  it "should get a device instance by name" do
    element_data = MachineShop::DeviceInstance.all({:name => device_instance.name}, auth_token)

    #puts "Device Instance: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

  it "should get all devices via a user" do
    element_data = user.device_instances

    #puts "Device Instance: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

  it "should get all devices via a user with a filter" do
    element_data = user.device_instances({:name => device_instance.name})

    #puts "Device Instance: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

end

describe MachineShop::Mapping do

  auth_token, user = MachineShop::User.authenticate(
      :email => publisher_username,
      :password => publisher_password
  )

  it "should get a geocoded address" do
    element_data = MachineShop::Mapping.geocode(
        {
            :address => "1600 Amphitheatre Parkway, Mountain View, CA",
            :sensor => "false"
        },
        auth_token)

    #puts "GEO: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

  it "should get directions" do
    element_data = MachineShop::Mapping.directions(
        {
            :origin => "Denver",
            :destination => "Boston",
            :sensor => "false"
        },
        auth_token)

    #puts "GEO: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

  it "should get distance" do
    element_data = MachineShop::Mapping.distance(
        {
            :origins => "Vancouver BC",
            :destinations => "San Francisco",
            :mode => "bicycling",
            :language => "fr-FR",
            :sensor => "false"
        },
        auth_token)

    #puts "GEO: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

end

describe MachineShop::Meter do

  auth_token, user = MachineShop::User.authenticate(
      :email => publisher_username,
      :password => publisher_password
  )

  it "should get all meter data" do
    element_data = MachineShop::Meter.all({}, auth_token)

    puts "element_data from all: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end

  it "should get meter by id " do

    element_data = MachineShop::Meter.retrieve('527ac622ff73462550000001', auth_token)
    puts "meter by id : #{element_data}"
    element_data.should_not be_nil
  end

  it "should get meters via a user" do
    element_data = user.meters

    puts "meters via user: #{element_data}"
    element_data.should_not be_nil
    element_data.should_not be_empty
  end

end

describe MachineShop::Report do

  auth_token, user = MachineShop::User.authenticate(
      :email => publisher_username,
      :password => publisher_password
  )

  it "should get all report data" do
    element_data = MachineShop::Report.all({}, auth_token)

    puts "element_data: #{element_data}"

    element_data.should_not be_nil
    element_data.should_not be_empty
  end



  it "should get report of specific device" do
    element_data = MachineShop::Report.all(
        ({:device_instance_id => '531f00e5981800ad58000006',
          :per_page=>'1000',
          #:created_at_between=>'2013-11-04T00:00:00_2014-03-19T17:02:00'
        }), auth_token)

    puts "element data of f00e5981800ad58000006 #{element_data} "

    element_data.should_not be_nil
  end


end

describe MachineShop::Rule do

  rules=nil
  auth_token, user = MachineShop::User.authenticate(
      :email => publisher_username,
      :password => publisher_password
  )
  it "should get all the rules " do

    #rules = MachineShop::Rule.new.get_rules(auth_token)
    rules = MachineShop::Rule.all({},auth_token)
    #get_rule
    puts "rules haru : #{rules}"
    rules.should_not be_nil


  end

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

  it "should create rule" do

    ruleById = MachineShop::Rule.retrieve(rules[0].id,auth_token)
    puts "rule by id  : #{ruleById}"
    ruleById.should_not be_nil

  end



  it "should get rule by id" do
    ruleById = MachineShop::Rule.retrieve(rules[0].id,auth_token)
    puts "rule by id  : #{ruleById}"
    ruleById.should_not be_nil

  end



  it "should get get join rule conditions" do
    test_data = MachineShop::Rule.get_join_rule_conditions(auth_token)
    puts "rule comparison  : #{test_data.inspect}"
    test_data.should_not be_nil

  end


  it "should get comparison rule_conditions" do
    test_data = MachineShop::Rule.new.get_comparison_rule_conditions(auth_token)
    puts "comparison rule condition  : #{test_data.inspect}"
    test_data.should_not be_nil

  end


  it "should get rules deleted" do
    test_data = MachineShop::Rule.get_by_device_instance(auth_token,'52585e1d981800bab2000478')
    puts "rule by_device_instance : #{test_data.inspect}"
    test_data.should_not be_nil

  end

  it "should get deleted rule" do
    test_data = MachineShop::Rule.get_deleted(auth_token)
    puts "deleted rule : #{test_data.inspect}"
    test_data.should_not be_nil

  end
  it "should get create rule" do
    test_data = MachineShop::Rule.create({},auth_token)
    puts "deleted rule : #{test_data.inspect}"
    test_data.should_not be_nil

  end


end

describe MachineShop::Util do

  auth_token, user = MachineShop::User.authenticate(
      :email => publisher_username,
      :password => publisher_password
  )

  it "should send an email" do
    element_data = MachineShop::Utility.email(
        {
            :subject => "hello there From the machineshop",
            :body => "The body of an email goes here.\nEscaped chars should work.",
            :to => "niroj@bajratechnologies.com"
        },
        auth_token)

    puts "element_data: #{element_data}"

    #element_data[:http_code].should be(200)
  end

  it "should send an sms" do
    element_data = MachineShop::Utility.sms(
        {
            :message => "This is a text from the platform",
            :to => "13035551212"
        },
        auth_token)

    #puts "element_data: #{element_data}"

    element_data[:http_code].should be(200)
  end

end

describe MachineShop::Customer do

  #update = MachineShop::Customer.update




  auth_token , user = MachineShop::User.authenticate(
      :email => publisher_username,
      :password => publisher_password
  )

  customers = nil

  it "should get all the customers " do
    customers = MachineShop::Customer.all({}, auth_token)

    puts "customers are #{customers}"

    #puts "first customer is : #{customers[0][:id]}"

    customers.should_not be_nil
  end


  it "should create customer " do

    customer = MachineShop::Customer.create({:email=>"gvhfbs@bajratechnologies.com",
                                             :password=>'password',
                                             :notification_method=>'sms',
                                             :first_name=>'niroj',:last_name=>'sapkota',
                                             :phone_number=>'98989898989',
                                             :company_name=>'technology co'

                                            },auth_token)
    puts "created customer is #{customer}"
    customer.should_not be_nil
  end


  specificCustomer = nil
  it "should get customer by customer id " do

    specificCustomer = MachineShop::Customer.retrieve(customers[0].id, auth_token)
    puts "customer id- #{customers[0].id}  is  #{specificCustomer}"
    specificCustomer.should_not be_nil
  end


=begin
  #success test

  it "should delete customer with id " do

    #puts
    puts "deleting customer with id : #{customers[0].id}"

    delete = specificCustomer.delete
    #delete = MachineShop::Customer.delete(customers[0].id,auth_token)
    puts "delete #{delete}"
    delete.http_code.should eq 200
  end



  it "should update the customer with id " do

    puts "updating customer with id : #{customers[0].id}"
    update = MachineShop::Customer.update(customers[0].id,auth_token,{:notification_method => 'email'})
    puts "update #{update}"
  end
end
=end
