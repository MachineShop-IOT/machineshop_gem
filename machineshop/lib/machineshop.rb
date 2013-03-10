require "machineshop/version"
require "machineshop/platform_api_calls"
require "machineshop/user_session_api_calls"
require "machineshop/api_helpers"
require "machineshop/config"

module MachineShop
  
  #User session calls
  def self.authenticate!(email, password)
    user = {
      email: email,
      password: password
    }
    
    response = ApiCalls.post_authenticate user
    #TODO Raise an error if not authenticated
    
    self.auth_token= response[:authentication_token]    
  end
  
  # Platform calls
  
  def self.get_rules
    ApiCalls.get_rule
  end

  def self.get_rule(id)
    ApiCalls.get_rule id
  end

  def get_device_instances
    ApiCalls.get_device_instances
  end

  def self.get_device(id)
    ApiCalls.get_device id
  end

  def self.get_device
    ApiCalls.get_device
  end

  def self.get_payload(device_id)
    ApiCalls.get_payload device_id
  end

  def self.get_join_rule_conditions
    ApiCalls.get_join_rule_conditions
  end

  def self.get_comparison_rule_conditions
    ApiCalls.get_comparison_rule_conditions
  end

  def self.create_rule(rule_json)
    #TODO Make this take params instead of JSON
    ApiCalls.post_rule rule_json
  end

  def self.delete_rule(id)
    ApiCalls.delete_rule id
  end

  def self.create_device(name, manufacturer, model,
    active, init_cmd, init_params, exe_path, unit_price,
    sample_data, long_description, image_url, manual_url)

    new_device_type = {
      name: name,
      manufacturer: manufacturer,
      model: model,
      active: active,
      init_cmd: init_cmd,
      init_params: init_params,
      exe_path: exe_path,
      unit_price: unit_price,
      sample_data: sample_data,
      long_description: long_description,
      image_url: image_url,
      manual_url: manual_url
    }

    ApiCalls.post_device new_device_type
  end

end
