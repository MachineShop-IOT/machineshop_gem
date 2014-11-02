module MachineShop
  module APIOperations
    module Delete
      def delete
        response = MachineShop.gem_delete(url, @auth_token,{})
        puts "response = " + response.to_s
        refresh_from(response, @auth_token)
        self
      end
    end
  end
end