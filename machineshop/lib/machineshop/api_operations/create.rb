#Defining class method inside a module
module MachineShop
  module APIOperations
    module Create
      module ClassMethods
        def create(params={}, auth_token=nil)
          ap "create rule endpoint " 
          ap self.url
          response = MachineShop.gem_post(self.url, auth_token, params)
          Util.convert_to_machineshop_object(response, auth_token, self.class_name)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
