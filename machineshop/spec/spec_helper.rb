require 'machineshop'
require "awesome_print"
require "active_support/core_ext"

MachineShop.configure do |config|
  config.db_name = "machineshop"
  config.db_username="root"
  config.db_password="root"
  config.db_host= "localhost"
  config.enable_caching=true,
  config.expiry_time= lambda{120.seconds.ago}
  #second
end
