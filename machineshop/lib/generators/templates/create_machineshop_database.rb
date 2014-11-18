class CreateMachineshopDatabase < ActiveRecord::Migration

    def change
        # puts ActiveRecord::Schema.new.migrations_paths
        # self.verbose = false
        # change_table(:device_caches) do |t|
        #     t.column :auth_token, :string, limit: 60
        # end


        create_table :api_endpoints do |t|
            t.string :_id
            t.string :verb
            t.string :endpoint
            t.string :auth_token
        end
        add_index :api_endpoints, [:verb,:endpoint], :unique=>true


        create_table :data_source_types_caches do |t|
            t.string :_id
            t.string :active
            t.string :type
            t.string :exe_path
            t.string :name
            t.string :image_url
            t.string :init_cmd
            t.string :init_params
            t.string :last_known_translator_port
            t.string :long_description
            t.string :user_id
            t.string :manual_url
            t.string :manufacturer
            t.string :updated_at
            t.string :created_at
            t.string :deleted_at
            t.string :model
            t.string :payload
            t.string :rule_ids
            t.string :sample_data
            t.string :software
            t.string :translator
            t.string :unit_price
            t.string :auth_token

        end

        create_table :data_sources_caches do |t|
            t.string :_id
            t.string :_type
            t.string :type
            t.string :last_checked_datetime
            t.string :name
            t.string :user_name
            t.string :sender
            t.string :encrypted_password
            t.string :pop_server
            t.string :port
            t.string :user_id
            t.string :auth_token
            t.string :data_source_type_id
            t.string :updated_at
            t.string :created_at
            t.text :data_source_type
            t.text :last_report
            t.string :report_count
            t.string :active

        end
        create_table :device_instance_caches do |t|
            t.string :_id
            t.string :alert_count
            t.string :name
            t.string :active
            t.string :device_id
            t.string :user_id
            t.string :auth_token
            t.string :updated_at
            t.string :created_at
            t.string :_type
            t.text :device
            t.text :last_report
            t.string :report_count
            t.string :tag_ids
            t.string :rule_ids
            t.string :user_type
            t.string :deleted_at

        end

        create_table :api_requests do |t|
            t.timestamps null: false
            t.text :url, null: false
            t.string :auth_token, null:false
        end

        create_table :report_caches do |t|
            t.string :_id
            t.string :created_at
            t.string :deleted_at
            t.string :device_datetime
            t.string :device_instance_id
            t.string :duplicate
            t.text :payload
            t.string :profile_timestamps
            t.string :raw_data
            t.string :report_processor
            t.string :stale
            t.string :updated_at
            t.string :auth_token
            t.string :data_source_id
        end

        create_table :comparison_rule_conditions_caches do |t|
            t.string :auth_token
            t.string :rule_condition
            t.string :rule_description
        end


        create_table :join_rule_conditions_caches do |t|
            t.string :rule_condition
            t.string :rule_description
            t.timestamp
        end

        create_table :rule_caches do |t|
            t.string :_id
            t.string :active
            t.string :created_at
            t.string :deleted_at
            t.string :description
            t.string :device_ids
            t.string :device_instance_ids
            t.string :downstream_rule_id
            t.string :last_run_status
            t.string :plain_english
            t.string :tag_ids
            t.string :then_actions
            t.string :updated_at
            t.string :user_id
            t.string :auth_token
            t.string :actions
            t.string :comparison_value
            t.string :deleted
            t.string :device_attribute
            t.string :last_run
            t.string :modified_date
            t.string :operator
            t.string :rule_histories
            t.string :else_actions
        end


        create_table :device_caches do |t|
            t.string :_id
            t.string :active
            t.string :created_at
            t.string :deleted_at
            t.string :exe_path
            t.string :image_url
            t.string :init_cmd
            t.string :init_params
            t.string :last_known_translator_port
            t.string :long_description
            t.string :manual_url
            t.string :manufacturer
            t.string :model
            t.string :name
            t.string :rule_ids
            t.string :sample_data
            t.string :software
            t.string :tag_ids
            t.string :translator
            t.string :type
            t.string :unit_price
            t.string :updated_at
            t.string :user_id
            t.string :auth_token
        end
    end

end