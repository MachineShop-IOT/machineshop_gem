require_relative '../spec_helper'

require 'machineshop/models/people'
#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'publisher@csr.com'
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
    puts "config.expiry_time #{config.expiry_time}"
  end

  it "should use activeRecord to create new record" do\







  end



  # db = MachineShop::Database.new


  it "stores into database" do
    # Database.new
    db = MachineShop::Database.new




  #   a="Devicecache"

  #   begin
  #     a.constantize.is_a?(Class)
  # l = a.constantize.all

  #   rescue NameError =>e
  #     puts "errorrrrr"
  #   end


  # ap "found"
  # ap l.as_json

  # puts "after db =========="
  # puts "db_connected ? #{db.db_connected}"
  # People.create(:first_name=>"lau",:last_name=>"khattam")

  ap "finding by first_name"
  rec = People.find_by(first_name: 'niroj')

  ap rec.as_json

  # if db.db_connected

  #   MachineShop::Database.insert('2343','endpoints',"/user/devices/id23")

  # end


end
end
