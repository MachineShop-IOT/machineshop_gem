module MachineShop
  module APIOperations
    module Delete
      def delete
        puts "inside mach delete"
        response = MachineShop.delete(url, @auth_token,{})
        refresh_from(response, @auth_token)
        self
      end
    end
  end
end