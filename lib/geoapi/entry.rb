module GeoAPI
  class Entry < GeoAPI::GeoObject
    
    attr_accessor :properties
    
    def initialize attrs
      self.properties = attrs['properties']
      
      super(attrs)
    end
  end
end