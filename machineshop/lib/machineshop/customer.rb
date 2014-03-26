module MachineShop
  class Customer < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create
    include MachineShop::APIOperations::Delete
    include MachineShop::APIOperations::Update

  end
end
