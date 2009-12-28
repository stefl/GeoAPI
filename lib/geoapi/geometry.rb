module GeoAPI
  class Geometry
    
    class_inheritable_accessor :geometry_type, :coords
    
    # Class methods
    
    def self.new_from_class_name class_name
      geom = case class_name.downcase.gsub('_','')
        
        when "point" then GeoAPI::Point.new
        
        when "polygon" then GeoAPI::Polygon.new
        
        when "multipoint" then GeoAPI::Polygon.new
          
      end
    
    end
    
    def self.from_json json
      attrs = Crack::JSON.parse(json)
      
      geom = Geometry.new_from_class_name json['type']
      
      unless geom.blank?
        
        geom.geometry_type = attrs['type']
      
        geom.coords = attrs['coordinates']
        
        geom
        
      end
      
    end
    
    def self.from_hash hash
      
      geom = Geometry.new_from_class_name hash['type']
      
      unless geom.blank?
        
        geom.geometry_type = hash['type']
      
        geom.coords = hash['coordinates']
        
        geom
      
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
    
  end
  
  class Point < GeoAPI::Geometry    
    def initialize lat=0, lng=0
      self.geometry_type = "Point"
      self.coords = [lat.to_f, lng.to_f]
    end
    

  end
  
  class Multipoint < GeoAPI::Geometry
    def initialize
      self.geometry_type = "Multipoint"
      self.coords = []
    end
    

  end
  
  class Polygon < GeoAPI::Geometry
    def initialize
      self.geometry_type = "Polygon"
      self.coords = []
    end
    

  end
  
  #todo add additional classes
  
end