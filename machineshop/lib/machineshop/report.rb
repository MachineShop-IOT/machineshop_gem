module MachineShop
  class Report < APIResource
    include MachineShop::APIOperations::List    
    
    # Specific API calls
    def get_data_monitor(auth_token, monitor_hash)
      url = platform_url + "/data/monitor"
      get url, auth_token, monitor_hash
    end

  end
end