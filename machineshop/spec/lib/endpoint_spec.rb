require_relative '../spec_helper'

#MachineShop.api_base_url= 'http://machineshop.dev:3000/api/v0'
MachineShop.api_base_url= 'http://stage.services.machineshop.io/api/v0'

publisher_username = 'admin@csr.com'
publisher_password = 'password'

MachineShop.configure do |config|
  config.db_name = "machineshop"
  config.db_username="root"
  config.db_password="root"
  config.db_host= "localhost"
  config.expiry_time= lambda{120.seconds.ago}
  #second
end

# auth_token, user = MachineShop::User.authenticate(
# :email => publisher_username,
# :password => publisher_password
# )

# ap "auth_token #{auth_token}"

ActiveRecord::Base.logger = Logger.new(STDOUT)

auth_token="2jzZmcHWLZyghsxcB16E"
 # => admin
 
# auth_token="WPyus6qzPxaPbNN1V5qb" # => publisher



describe MachineShop::EndPoints do
  element_data = MachineShop::EndPoints.all("v0",auth_token)
  #   # element_data = MachineShop::EndPoints.all({:namespace=>"secm"},auth_token)
end