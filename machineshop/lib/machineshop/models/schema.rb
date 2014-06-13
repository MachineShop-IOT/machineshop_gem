ActiveRecord::Schema.define do
  self.verbose = false
  create_table :people do |t|
    t.string :first_name
    t.string :last_name
    t.string :short_name
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
  end



end