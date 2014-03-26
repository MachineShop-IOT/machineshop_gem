#Defining class method inside a module
module MachineShop
  module APIOperations
    module Update
      module ClassMethods
        def update(id,auth_token,params={})
          response = MachineShop.put(self.url+"/#{id}", auth_token, params)
          Util.convert_to_machineshop_object(response, auth_token, self.class_name)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
=begin


module MachineShop
  module APIOperations
    module Update
      def self.update(param={})
        #puts "inside mach update with param : #{param}"
        puts "self has : #{self.inspect}"
        #response = MachineShop.update(url, @auth_token,params)
        #refresh_from(response, @auth_token)
        self
      end
    end
  end
end
=end
