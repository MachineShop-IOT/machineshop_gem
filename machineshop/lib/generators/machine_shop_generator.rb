
require 'rails/generators'
require 'rails/generators/migration'

class MachineShopGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  
  def self.source_root
    @source_root ||= File.expand_path('../templates', __FILE__)
  end

  # Implement the required interface for Rails::Generators::Migration.
  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_migration_file
    migration_template 'create_machineshop_database.rb', 'db/migrate/create_machineshop_database.rb'
    # copy_file 'config.yml', 'config/machine_shop/config.yml'
  end      
end