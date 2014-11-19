module MachineShop

  require 'machineshop/errors/machineshop_error'
  # require 'machineshop/errors/api_error'
  require 'machineshop/errors/database_error'
  require 'machineshop/errors/schema_error'
  require 'mysql'
  require 'active_record'
  # require 'machineshop/configuration'

  class Database < Configuration

    attr_accessor :con, :rs,:db_connected

    def initialize()

      # @db_connected=true
      begin


        ActiveRecord::Base.establish_connection(
          # Rails.configuration.database_configuration[Rails.env]

        adapter:  'mysql', # or 'postgresql' or 'sqlite3'
        host:     MachineShop.configuration.db_host,
        database: MachineShop.configuration.db_name,
        username: MachineShop.configuration.db_username,
        password: MachineShop.configuration.db_password,
        )

      rescue ActiveRecord::AdapterNotSpecified =>e
        raise DatabaseError.new(e)
      rescue ActiveRecord::AdapterNotFound =>e
        raise DatabaseError.new(e)
      rescue StandardError =>e
        raise DatabaseError.new(e)
      rescue Exception => e
        # @db_connected=false
        raise DatabaseError.new("Connection to Database refused")
        # load schema file
      end





    end

    def self.serialize_data(data)
      Marshal.dump(data)
    end

  end


end