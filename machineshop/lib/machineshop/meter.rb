module MachineShop
  class Meter < APIResource
  include MachineShop::APIOperations::List    

    def self.url()    
      "/platform/data/#{CGI.escape(class_name.underscore)}"
    end
    
  end

end