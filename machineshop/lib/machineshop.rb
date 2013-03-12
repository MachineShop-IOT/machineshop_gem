require "machineshop/version"
require "machineshop/platform_api_calls"
require "machineshop/user_session_api_calls"
require "machineshop/api_helpers"
require "machineshop/config"

module MachineShop
  class << self
    #User session calls
    def authenticate(email, password)
      response = ApiCalls.post_authenticate({:email => email, :password => password})
      #TODO Raise an error if not authenticated

      auth_token = response[:authentication_token]
      [auth_token, response]
    end

    # Platform calls

    def get_rules(auth_token)
      ApiCalls.get_rules auth_token
    end

    def get_rule(auth_token, id)
      ApiCalls.get_rule auth_token, id
    end

    def get_device_instances(auth_token)
      ApiCalls.get_device_instances auth_token
    end

    def get_device_instance_reports(auth_token, device_instance_id)
      ApiCalls.get_data_monitor auth_token, {:device_instance_id => device_instance_id}
    end

    def get_device_instance_last_report(auth_token, device_instance_id)
      ApiCalls.get_data_monitor auth_token, {:per_page => 1, :device_instance_id => device_instance_id}
    end

    def get_device(auth_token, id)
      ApiCalls.get_device auth_token, id
    end

    def get_devices(auth_token)
      ApiCalls.get_devices auth_token
    end

    def get_payload(device_id)
      ApiCalls.get_payload auth_token, device_id
    end

    def get_join_rule_conditions(auth_token)
      ApiCalls.get_join_rule_conditions auth_token
    end

    def get_comparison_rule_conditions(auth_token)
      ApiCalls.get_comparison_rule_conditions auth_token
    end

    def create_rule(auth_token, rule_json)
      #TODO Make this take params instead of JSON
      ApiCalls.post_rule auth_token, rule_json
    end

    def delete_rule(auth_token, id)
      ApiCalls.delete_rule auth_token, id
    end

    def create_device(auth_token, name, manufacturer, model,
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

      ApiCalls.post_device auth_token, new_device_type
    end
  end
end
