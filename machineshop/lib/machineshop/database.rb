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

    # attr_accessor :con, :rs,:db_connected

    def initialize()

      puts "____calling _______"

      # @db_connected=true
      begin
        ap "________________"

        ap ActiveRecord::Base.configurations[Rails.env]

        # ActiveRecord::Base.establish_connection ActiveRecord::Base.configurations[Rails.env]

ActiveRecord::Base.establish_connection(
        # adapter:  'mysql', # or 'postgresql' or 'sqlite3'

        ActiveRecord::Base.configurations[Rails.env]

  #       adapter: 'postgresql',
  # encoding: 'unicode',
  # database: 'machineshop',
  # pool: 5,
  # username: 'niroj',
  # password: 'niroj123'


        # adapter: 'mysql',
        # host:     'localhost',
        # database: 'machineshop',
        # username: 'root',
        # password: 'root'

        # -----------------------------
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
        # load schema file
      end





    end

    def self.serialize_data(data)
      Marshal.dump(data)
    end

  end


end