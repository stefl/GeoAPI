module GeoAPI
  class Geometry
    
    class << self
      attr_accessor :coords
    end
  
    
    # Class methods
    
    def self.new_from_class_name class_name
      geom = case class_name.downcase.gsub('_','')
        
        when "point" then GeoAPI::Point.new
        
        when "polygon" then GeoAPI::Polygon.new
        
        when "multipoint" then GeoAPI::Polygon.new
          
      end
    
    end
    
    def self.from_json json
      unless json.blank?
        attrs = Crack::JSON.parse(json)
      
        geom = Geometry.new_from_class_name json['type']
      
        unless geom.blank?
        
          geom.geometry_type = attrs['type']
      
          geom.coords = attrs['coordinates']
        
          geom
        
        end
      end
    end
    
    def self.from_hash hash
      unless hash.blank?
        geom = Geometry.new_from_class_name hash['type']
      
        unless geom.blank?
        
          geom.geometry_type = hash['type']
      
          geom.coords = hash['coordinates']
        
          geom
      
        end
      end
    end
    
    
    # Instance methods
    
    def coordinates
      coords
    end
    
    def type
      geometry_type
    end
    
    def to_json options=nil
      {:type=>self.geometry_type, :coordinates=>self.coords}.to_json
    end
    
    def initialize attrs
      @geometry_type = self.class.name
    end
    
  end
  
  class Point < GeoAPI::Geometry    
    
    def initialize attrs
      
      raise ArgumentError, ":lat (latitude) must be sent as an attribute to the GeoAPI::Point constructor" unless attrs.has_key?[:lat]
      raise ArgumentError, ":lng (longitude) must be sent as an attribute to the GeoAPI::Point constructor" unless attrs.has_key?[:lng]
      
      @coords = [attrs[:lat].to_f, attrs[:lng].to_f]
      super attrs
    end
    

  end
  
  class Multipoint < GeoAPI::Geometry
    
  
    def initialize attrs
      
      self.coords = []
      super attrs
    end
    

  end
  
  class Polygon < GeoAPI::Geometry
        
    def initialize attrs
      self.coords = [] 
      super attrs
    end
    

  end
  
  #todo add additional classes
  
end