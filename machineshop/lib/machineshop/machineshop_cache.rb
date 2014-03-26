module MachineShop
  class MachineshopCache
    #require 'Rails'
    #require 'active_support/cache'
    require 'active_record'
    cache = ActiveSupport::Cache.lookup_cache(:memory_store)

    Rails.cache.class.class_eval do
      attr_accessor :enabled

      def read_with_enabled(*args, &block)
        enabled ? read_without_enabled( *args, &block) : nil
      end

      alias_method_chain :read, :enabled

    end

    if File.basename($0) == "rake" && ARGV.include?("db:migrate")
      Rails.cache.enabled = false

    else
      Rails.cache.enabled = true

    end
  end

  describe "Rails.cache" do
    it 'can be disabled and enabled' do
      Rails.cache.enabled = true
      Rails.cache.enabled.should be_true
      Rails.cache.write("foobar","foo")
      Rails.cache.read("foobar").should == "foo"

      Rails.cache.enabled = false
      Rails.cache.enabled.should be_false
      Rails.cache.write("foobar","foo")
      Rails.cache.read("foobar").shoule be_nil

      Rails.cache.enabled = true
      Rails.cache.read("foobar").should == "foo"


    end

  end


end
