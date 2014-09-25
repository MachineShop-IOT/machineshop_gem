module MachineShop
  class Report < APIResource
    include MachineShop::APIOperations::List    
    include MachineShop::APIOperations::Create    
    
    def self.url()
      "/monitor/#{CGI.escape(class_name.underscore)}"
    end

  end
end