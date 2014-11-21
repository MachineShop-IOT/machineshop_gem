module MachineShop

  require 'machineshop/errors/machineshop_error'
  # require 'machineshop/errors/api_error'
  require 'machineshop/errors/database_error'
  require 'machineshop/errors/schema_error'
  require 'mysql'
  require 'active_record'
  # require 'machineshop/configuration'

  # class Database
  class Database < Configuration
    def initialize()
      begin
        # ap ActiveRecord::Base.configurations[Rails.env]
        ActiveRecord::Base.establish_connection(
          ActiveRecord::Base.configurations[Rails.env]
        )

      rescue ActiveRecord::AdapterNotSpecified =>e
        puts "yaha1"
        raise DatabaseError.new(e)
      rescue ActiveRecord::AdapterNotFound =>e
        puts "yaha2"
        raise DatabaseError.new(e)
      rescue StandardError =>e
        puts "yaha3"
        raise DatabaseError.new(e)
      rescue Exception => e
        puts "yaha4"
        # @db_connected=false
        # raise DatabaseError.new("Connection to Database refused "+e)
        raise DatabaseError.new(e)
      end

    end

  end
end