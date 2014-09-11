require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://localhost:3000/api/v1'
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



describe MachineShop::DataSourceTypes do

 
specific_data_source = nil

data_source = nil

  it "should get all DataSource types for the user" do
    element_data = MachineShop::DataSourceTypes.all(
        {:page => 1,
         :per_page => 10},
        auth_token)

    ap element_data

    data_source = element_data[0]
    expect(data_source).to be_truthy
  end


  it "should create data_source_type" do 
    element_data = MachineShop::DataSourceTypes.create(
      {     
        :exe_path =>"/path/exe",
        :image_url =>"http://yahoo.com",
        :init_cmd =>"start it up",
        :init_params =>"now=true",
        # :last_known_translator_port =>"null",
        :long_description =>"Rajat's mobile",
        :manual_url =>"http://snap.com",
        :manufacturer =>"Snapdragon",
        :model =>"Chinese",
        :name =>"One Plus Onefrom gem",
        :sample_data =>"expect this back",        
        :software =>"Android 4.04",
        # :translator =>"null",
        :type =>"Phone",
        :unit_price =>"$100.00",        
        :active =>"true",
        :payload =>"device.type"
        }, auth_token
      )
  end

  # it "should get a data_source for the user by id" do
  #   specific_data_source = MachineShop::DataSources.retrieve(data_source.id, auth_token)

  #   ap specific_data_source

  #   specific_data_source.should_not be_nil
  #   # specific_data_source.should be_kind_of MachineShop::DataSources
  # end

end
