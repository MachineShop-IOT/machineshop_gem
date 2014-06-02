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
