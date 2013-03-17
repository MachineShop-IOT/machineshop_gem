module MachineShop
  class DeviceInstance < APIResource
    include MachineShop::APIOperations::List
    include MachineShop::APIOperations::Create
    include MachineShop::APIOperations::Delete
    
    # Specific API calls
    def get_device_instances(auth_token, hash_params)
      url = platform_url + "/device_instance"
      get url, auth_token, hash_params
    end

    def get_device_instance_report_count(auth_token, id)
      url = platform_url + '/platform/device_instance/' + id + '/report_count'
      get url, auth_token
    end

  end
end
