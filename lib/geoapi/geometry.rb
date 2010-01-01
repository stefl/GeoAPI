module GeoAPI
  class Geometry
    
    class << self
      attr_accessor :coords, :geometry_type
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
    
    attr_accessor :geometry_type, :coords
    
    def initialize *args
      
      params = args.extract_options!
      params = params == {} ? nil : params
      
      puts "GEOAPI::Point.new #{params.to_json}"
      
      raise ArgumentError, ":lat (latitude) must be sent as a parameter to the GeoAPI::Point constructor" unless params.has_key?(:lat)
      raise ArgumentError, ":lng (longitude) must be sent as a parameter to the GeoAPI::Point constructor" unless params.has_key?(:lng)
      
      self.coords = [params[:lat].to_f, params[:lng].to_f]
      super args
    end
    

  end
  
  class Multipoint < GeoAPI::Geometry
    
    attr_accessor :geometry_type, :coords
  
    def initialize attrs
      
      self.coords = []
      super attrs
    end
    

  end
  
  class Polygon < GeoAPI::Geometry
        
    attr_accessor :geometry_type, :coords
    
    def initialize attrs
      self.coords = [] 
      super attrs
    end
    

  end
  
  #todo add additional classes
  
end