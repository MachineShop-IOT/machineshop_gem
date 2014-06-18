module MachineShop
  class MachineShopObject
    include Enumerable

    attr_accessor :auth_token
    @@permanent_attributes = Set.new([:auth_token, :id])

    # The default :id method is deprecated and isn't useful to us
    if method_defined?(:id)
      undef :id
    end

    def initialize(id=nil, auth_token=nil)
      # parameter overloading!
      if id.kind_of?(Hash)
        @retrieve_options = id.dup
        @retrieve_options.delete(:id)
        id = id[:id] ? id[:id] : id[:_id]
      else
        @retrieve_options = {}
      end

      @auth_token = auth_token    

      @values = {}
      # This really belongs in APIResource, but not putting it there allows us
      # to have a unified inspect method
      @unsaved_values = Set.new
      @transient_values = Set.new
      self.id = id if id
    end

    def self.construct_from(values, auth_token=nil)
      values[:id] = values[:_id] if values[:_id]
      obj = self.new(values[:id], auth_token)
      obj.refresh_from(values, auth_token)
      obj
    end

    def to_s(*args)
      MachineShop::JSON.dump(@values, :pretty => true)
    end

    def inspect()
      id_string = (self.respond_to?(:id) && !self.id.nil?) ? " id=#{self.id}" : ""
      "#<#{self.class}:0x#{self.object_id.to_s(16)}#{id_string}> JSON: " + MachineShop::JSON.dump(@values, :pretty => true)
    end

    def refresh_from(values, auth_token, partial=false)
      @auth_token = auth_token
      case values
      when Array
        values = values[0]
      else
        #do nothing
      end
      values[:id] = values[:_id] if values[:_id]

      removed = partial ? Set.new : Set.new(@values.keys - values.keys)
      added = Set.new(values.keys - @values.keys)

      instance_eval do
        remove_accessors(removed)
        add_accessors(added)
      end
      removed.each do |k|
        @values.delete(k)
        @transient_values.add(k)
        @unsaved_values.delete(k)
      end
      values.each do |k, v|
        @values[k] = Util.convert_to_machineshop_object(v, auth_token)
        @transient_values.delete(k)
        @unsaved_values.delete(k)
      end
    end

    def [](k)
      k = k.to_sym if k.kind_of?(String)
      @values[k]
    end

    def []=(k, v)
      send(:"#{k}=", v)
    end

    def keys
      @values.keys
    end

    def values
      @values.values
    end

    def to_json(*a)
      MachineShop::JSON.dump(@values)
    end

    def as_json(*a)
      @values.as_json(*a)
    end

    def to_hash
      @values
    end

    def each(&blk)
      @values.each(&blk)
    end

    protected

    def metaclass
      class << self; self; end
    end

    def remove_accessors(keys)
      metaclass.instance_eval do
        keys.each do |k|
          next if @@permanent_attributes.include?(k)
          k_eq = :"#{k}="
          remove_method(k) if method_defined?(k)
          remove_method(k_eq) if method_defined?(k_eq)
        end
      end
    end

    def add_accessors(keys)
      metaclass.instance_eval do
        keys.each do |k|
          next if @@permanent_attributes.include?(k)
          k_eq = :"#{k}="
          define_method(k) { @values[k] }
          define_method(k_eq) do |v|
            @values[k] = v
            @unsaved_values.add(k)
          end
        end
      end
    end

    def method_missing(name, *args)
      # TODO: only allow setting in updateable classes.
      if name.to_s.end_with?('=')
        attr = name.to_s[0...-1].to_sym
        @values[attr] = args[0]
        @unsaved_values.add(attr)
        add_accessors([attr])
        return
      else
        return @values[name] if @values.has_key?(name)
      end

      begin
        super
      rescue NoMethodError => e
        if @transient_values.include?(name)
          raise NoMethodError.new(e.message + ".  HINT: The '#{name}' attribute was set in the past, however.  It was then wiped when refreshing the object with the result returned by MachineShop's API, probably as a result of a save().  The attributes currently available on this object are: #{@values.keys.join(', ')}")
        else
          raise
        end
      end
    end
  end
end
