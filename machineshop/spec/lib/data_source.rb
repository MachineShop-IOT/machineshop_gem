require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://localhost:3000/api/v1'

#publisher_username = 'publisher@machineshop.com'
publisher_username = 'publisher@csr.com'
publisher_password = 'password'


MachineShop.configure do |config|
  config.expiry_time = lambda{120.seconds.ago}
  config.enable_caching = false
  config.db_username="root"
  config.db_password="root"
  config.db_name="machineshop"
end

auth_token, user = MachineShop::Users.authenticate(
:email => publisher_username,
:password => publisher_password
)



describe MachineShop::DataSources do


  specific_data_source = nil

  data_source = nil
  data_source_type = nil

  it "should get all DataSources for the user" do
    element_data = MachineShop::DataSources.all(
    {:page => 1,
    :per_page => 10},
    auth_token)

    ap element_data

    data_source = element_data[0]
    expect(data_source).to be_truthy
  end


  it "should update the DataSource " do
    toUpdate = MachineShop::DataSources.retrieve(data_source.id, auth_token)

    update = toUpdate.update({:name => "updated name"})

  end

  it "should delete datasource" do
    toDelete = MachineShop::DataSources.retrieve(data_source.id,auth_token)
    # ap toDelete

    deleted = toDelete.delete
    # ap deleted
  end



  it "should get all  DataSourceTypes" do
    element_data = MachineShop::DataSourceTypes.all(
    {:page => 1,
    :per_page => 10},
    auth_token)
    data_source_type = element_data[0]
  end

  it "should retrieve DataSource " do
    specificDataSource = MachineShop::DataSourceTypes.retrieve(data_source_type.id, auth_token)

    data_source = specificDataSource.create_data_source(

    {:data_source =>"device",
      # :data_source_type =>"5406d665faf3d9d39100000a",
      :name =>"gem bata banako device type",
      :user_name =>"niroj_username",
      :sender =>"niroj@sender.com",
      :password =>"password",
      :pop_server =>"port_server",
      :port =>"345"
    })

  end


  it "should get create email DataSource " do

    specificDataSource = MachineShop::DataSourceTypes.retrieve(data_source_type.id, auth_token)

    data_source = specificDataSource.create_email_data_source(

    {:data_source =>"device",
      # :data_source_type =>"5406d665faf3d9d39100000a",
      :name =>"gem bata banako email data source",
      :user_name =>"gem_username",
      :sender =>"droplet@sender.com",
      :password =>"niroj_password",
      :pop_server =>"niroj.com",
      :port =>"12345"
    })

  end


  # it "should get a data_source for the user by id" do
  #   specific_data_source = MachineShop::DataSources.retrieve(data_source.id, auth_token)

  #   ap specific_data_source

  #   specific_data_source.should_not be_nil
  #   # specific_data_source.should be_kind_of MachineShop::DataSources
  # end


  #   it "should create data_source" do
  #     data_source_instance = specific_data_source.create_instance(
  #     {
  #         :name => "My little instance",
  #         :active => "yes"
  #     }


  # )

  #   end



  # it "should get instances of data_source data_source" do
  #   ins = specific_data_source.instances

  # end

end
