module MachineShop
  class Reports < APIResource
    include MachineShop::APIOperations::List    
    include MachineShop::APIOperations::Create    
    
    def self.url()
      ret = "/monitor/#{CGI.escape(class_name.underscore)}"
      ap ret
      ret
    end

  end
end