module MachineShop
require 'active_record'

require 'machineshop/database'

Database.new

class People < ActiveRecord::Base
end

end