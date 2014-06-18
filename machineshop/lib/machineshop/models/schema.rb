ActiveRecord::Schema.define do
    # puts ActiveRecord::Schema.new.migrations_paths
    # self.verbose = false
    # change_table(:device_caches) do |t|
    #     t.column :auth_token, :string, limit: 60
    # end

    change_table(:rule_caches) do |t|
        t.column :actions, :string
        t.column :comparison_value, :string
        t.column :deleted, :string
        t.column :device_attribute, :string
        t.column :last_run, :string
        t.column :modified_date, :string
        t.column :operator, :string
        t.column :rule_histories, :string
        t.column :else_actions=, :string
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