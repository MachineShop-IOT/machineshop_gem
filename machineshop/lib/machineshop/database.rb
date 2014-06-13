module MachineShop

  require 'machineshop/errors/machineshop_error'
  require 'machineshop/errors/api_error'
  require 'machineshop/errors/database_error'
  require 'mysql'
  require 'active_record'
  require 'machineshop/configuration'

  class Database < Configuration

    attr_accessor :con, :rs,:db_connected

    def initialize()

      @db_connected=true

      begin

        ActiveRecord::Base.establish_connection(
        adapter:  'mysql', # or 'postgresql' or 'sqlite3'
        host:     MachineShop.configuration.db_host,
        database: "machineshop",
        username: MachineShop.configuration.db_username,
        password: "root"
        )

        # load schema file
        load 'machineshop/models/schema.rb'
      rescue Exception => e
        @db_connected=false
        return @db_connected

        raise DatabaseError.new("Connection to Database refused")
      end


    end

    def self.serialize_data(data)
      Marshal.dump(data)
    end

  end


end