module GeoAPI
  class Geometry
    
    class << self
      attr_accessor :coords
    end
    
    cattr_accessor :geometry_type
    
    # From Rails core: http://caboo.se/doc/classes/Class.html#M004152
    
    def cattr_accessor(*syms)
       cattr_reader(*syms)
       cattr_writer(*syms)
     end
    
    def cattr_reader(*syms)
       syms.flatten.each do |sym|
         next if sym.is_a?(Hash)
         class_eval("unless defined? @@\#{sym}\n@@\#{sym} = nil\nend\n\ndef self.\#{sym}\n@@\#{sym}\nend\n\ndef \#{sym}\n@@\#{sym}\nend\n", __FILE__, __LINE__)
       end
     end
     
    def cattr_writer(*syms)
       options = syms.extract_options!
       syms.flatten.each do |sym|
         class_eval("unless defined? @@\#{sym}\n@@\#{sym} = nil\nend\n\ndef self.\#{sym}=(obj)\n@@\#{sym} = obj\nend\n\n\#{\"\ndef \#{sym}=(obj)\n@@\#{sym} = obj\nend\n\" unless options[:instance_writer] == false }\n", __FILE__, __LINE__)
       end
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