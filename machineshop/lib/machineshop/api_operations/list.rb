module MachineShop
  module APIOperations
    module List
      module ClassMethods
        def all(filters={}, auth_token=nil)
          response = MachineShop.gem_get(url, auth_token, filters)
          Util.convert_to_machineshop_object(response, auth_token, self.class_name)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
