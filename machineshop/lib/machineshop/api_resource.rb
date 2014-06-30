module MachineShop
  class APIResource < MachineShopObject
    def self.class_name
      self.name.split('::')[-1]
    end

    def self.url()
      if self == APIResource
        raise NotImplementedError.new('APIResource is an abstract class.  You should perform actions on its subclasses (Device, Rule, etc.)')
      end
      ret = "/platform/#{CGI.escape(class_name.underscore)}"
      ret
    end

    def url
      unless id = self['id']
        raise InvalidRequestError.new("Could not determine which URL to request: #{self.class} instance has invalid ID: #{id.inspect}", 'id')
      end      
      ret = "#{self.class.url}/#{CGI.escape(id)}"
      ret
    end

    def refresh      
      response = MachineShop.gem_get(url, @auth_token)
      refresh_from(response, auth_token)
      self
    end

    def self.retrieve(id, auth_token=nil)
      instance = self.new(id, auth_token)
      instance.refresh
      instance
    end
  end
end
