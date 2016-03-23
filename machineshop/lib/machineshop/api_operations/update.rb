#Defining class method inside a module
module MachineShop
  module APIOperations
    module Update
        def update(param={})
          ap '---- randi jasto aucha ta yeha ?'
          response = MachineShop.gem_put(url, @auth_token,param)
          refresh_from(response, @auth_token)
        end
    end
  end
end
