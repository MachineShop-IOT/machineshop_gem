module MachineShop
  class GatewayDataSourceTypes < APIOperations
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create
    include MachineShop::APIOperations::Update
    include MachineShop::APIOperations::Delete

  end
end
