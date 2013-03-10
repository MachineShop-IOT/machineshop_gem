require "machineshop/version"
require "machineshop/api_calls"

module MachineShop
  def self.auth_token=(auth_token)
    ApiCalls.auth_token= auth_token
  end

  def self.auth_token
    ApiCalls.auth_token
  end

  def self.api_base=(api_base)
    ApiCalls.api_base= api_base
  end

  def self.api_base
    ApiCalls.api_base
  end

  def self.platform_endpoint=(platform_endpoint)
    ApiCalls.platform_endpoint= platform_endpoint
  end

  def self.platform_endpoint
    ApiCalls.platform_endpoint
  end

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
    ApiCalls.create_rule rule_json
  end

  def self.delete_rule(id)    
    ApiCalls.delete_rule id
  end

end
