module MachineShop

  require 'machineshop/errors/machineshop_error'
  # require 'machineshop/errors/api_error'
  require 'machineshop/errors/database_error'
  require 'machineshop/errors/schema_error'
  require 'mysql'
  require 'active_record'
  # require 'machineshop/configuration'

  class Database < ActiveRecord::Base
  # class Database < Configuration

    attr_accessor :con, :rs,:db_connected

    def initialize()

      # @db_connected=true
      begin

        establish_connection ActiveRecord::Base.configurations[Rails.env]



  #       ActiveRecord::Base.establish_connection(
  #         # Rails.configuration.database_configuration[Rails.env]

  #         adapter: 'sqlite3',
  # database: 'db/development.sqlite3',
  # pool: '5',
  # timeout: '5000'

  # # -----------------------------------


  #       # adapter:  'mysql', # or 'postgresql' or 'sqlite3'
  #       # host:     MachineShop.configuration.db_host,
  #       # database: MachineShop.configuration.db_name,
  #       # username: MachineShop.configuration.db_username,
  #       # password: MachineShop.configuration.db_password,

  #       # -----------------------------
  #       )

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
        # load schema file
      end





    end

    def self.serialize_data(data)
      Marshal.dump(data)
    end

  end


end