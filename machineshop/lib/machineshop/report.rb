module MachineShop
  class Report < APIResource
    include MachineShop::APIOperations::List    
    
    def self.url()
      ret = "/monitor/#{CGI.escape(class_name.underscore)}"
      ret
    end

  end
end