module MachineShop
  class Database  < Configuration
    require 'mysql'

    # require "machineshop/configuration"

    # attr_accessor :con


    attr_accessor :con, :rs, :config

    def initialize(config=Configuration.new)

    @config=config

    begin
    @@con = Mysql.new(MachineShop.configuration.db_host,MachineShop.configuration.db_username,MachineShop.configuration.db_password,MachineShop.configuration.db_name)
      
    rescue Exception => e
      puts e.message
    end

    @rs = @@con.query('select url from endpoints')
    @rs.each_hash { |h| puts h['url']}
    #con.close
  end


  def self.insert(table_name , data={})

    @@con.query("INSERT INTO `endpoints` (`id`, `url`) VALUES (NULL, '#{data}')")
  end

  def self.serialize_data(data)
    Marshal.dump(data)
  end

end

end
# Database.new
# Database.insert('endpoints',"/user/devices/id")