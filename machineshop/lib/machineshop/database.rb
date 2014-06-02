module MachineShop
=begin

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
    @@con = Mysql.new(MachineShop.configuration.db_host,MachineShop.configuration.db_username,MachineShop.configuration.db_password,MachineShop.configuration.db_name)

 @act = ActiveRecord::Base.establish_connection(
  adapter:  'mysql', # or 'postgresql' or 'sqlite3'
  host:     MachineShop.configuration.db_host,
  # database: MachineShop.configuration.db_name,
  database: "machineshop",
  username: MachineShop.configuration.db_username,
  # password: MachineShop.configuration.db_password
  password: "root"
  )

 ActiveRecord::Migration.class_eval do
  create_table :devices do |t|
        t.string :_id
        t.string :active
        t.string :created_at
        t.string :deleted_at
        t.string :exe_path
        t.string :image_url
        t.string :init_cmd
        t.string :init_params
        t.string :last_known_translator_port
        t.string :long_description
        t.string :manual_url
        t.string :manufacturer
        t.string :model
        t.string :name
        t.string :rule_ids
        t.string :sample_data
        t.string :software
        t.string :tag_ids
        t.string :translator
        t.string :type
        t.string :unit_price
        t.string :updated_at
        t.string :user_id
   end

   create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :short_name
   end

   create_table :tags do |t|
      t.string :tags
   end 
end
# puts "act is #{@act.inspect}"

      
    rescue Exception => e
      @db_connected=false
     return @db_connected

    raise DatabaseError.new("Connection to Database refused")
  end

    @rs = @@con.query('select url from endpoints')
    @rs.each_hash { |h| puts h['url']}
  end

  # def database_error(error)
  #   DatabaseError.new(error)
  # end



  def self.insert(user_id, table_name, data={})
    @rs = @@con.query("INSERT INTO #{table_name} (`id`, `url`) VALUES (NULL, '#{data}')")
puts "inserted #{@rs.inspect}"
  end


  def self.get(user_id,table_name,filter={})
    @rs = @@con.query("SELECT * FROM #{table_name}")
    puts "get  #{@rs.inspect}"
  end

  def self.serialize_data(data)
    Marshal.dump(data)
  end

end

end
=end

end

# Database.new
# Database.insert('endpoints',"/user/devices/id")