module MachineShop
  class Report < APIResource
    include MachineShop::APIOperations::List    
    
    def self.url()
      ret = "/monitor/#{CGI.escape(class_name.underscore)}"
      puts "Returning url: #{ret}"
      ret
    end

  end
end