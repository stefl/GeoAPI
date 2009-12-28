module GeoAPI
  class Entity < GeoAPI::GeoObject
    
    attr_accessor  :guid, :name, :entity_type, :geom, :url, :latitude, :longitude, :views, :userviews, :raw_json, :errors, :shorturl, :raw_json
    
    alias_method :lat, :latitude 
    alias_method :lon, :longitude
    alias_method :geometry, :geom


    # Class methods
    
    
    def self.create(params)
      #required: name, geom
      #optional: pass id and it will create a new guid for you as user-<apikey>-<id>
      
      raise ArgumentError, "A name is required (pass :name in parameters)" unless params.has_key?(:name)
      raise ArgumentError, "A geometry is required (pass :geom in parameters)" unless params.has_key?(:geom)
      
      post_url = "/e" 
      post_url = "/e/user-#{GeoAPI::API_KEY}-#{params[:id]}" unless params[:id].blank?
      post_url = "/e/#{params[:guid]}" unless params[:guid].blank?

      pp post_url
      
      begin
        results = Entity.post(post_url, {:body=> params.to_json}) 
      rescue
        raise BadRequest, "There was a problem communicating with the API"
      end
      raise BadRequest, results['error'] unless results['error'].blank?
      
      #todo the result does not contain the guid, so merge it back in. Possible point of failure here?
      Entity.new(results['result'].merge({'guid'=>results['query']['params']['guid']}))
    end
    
    def self.destroy(params)
      raise ArgumentError, "An id or guid is required (pass :id or :guid in parameters)"  unless params.has_key?(:id) || params.has_key?(:guid)      
      
      begin
        unless params[:guid].blank?
          delete("/e/#{params[:guid]}") 
        else
          delete("/e/user-#{GeoAPI::API_KEY}-#{params[:guid]}") unless params[:id].blank?
        end
      
      rescue
        raise BadRequest, "There was a problem communicating with the API"
      end
    end
    
    def self.create_at_lat_lng(params, lat, lng)
      p = GeoAPI::Point.new(lat,lng)
      
      self.create(params.merge({:geom=>p}))
    end
    
    def self.find(*args)
      
      raise ArgumentError, "First argument must be symbol (:all or :get)" unless args.first.kind_of?(Symbol)
      
      params = args.extract_options!
      params = params == {} ? nil : params
      
      
      case args.first
        
        when :all
          results = []
        else
          results = nil
          raise ArgumentError, "Arguments should include a :guid" if params[:guid].blank?
        
          begin
            response = get("/e/#{params[:guid]}")
          rescue
            raise BadRequest, "There was a problem communicating with the API"
          end
        
          results = Entity.new(response['result'].merge({'guid'=>params[:guid]})) unless response['result'].blank? #the api doesn't return a guid in json?!
      end
            
      results
      
    end
    
    def self.find_by_id(the_id)
      self.find(:get, :guid=>"user-#{GeoAPI::API_KEY}-#{the_id}")
    end
    
    
    
    
    # Instance methods
    def initialize(attrs)
      self.guid = attrs['guid'] unless attrs['guid'].blank?
      self.guid = "user-#{GeoAPI::API_KEY}-#{attrs['id']}" unless attrs['id'].blank?
      self.errors = attrs['error']
      self.name = attrs['name']
      self.entity_type = attrs['type']
      self.geom = GeoAPI::Geometry.from_hash(attrs['geom'])
      self.views = attrs['views']
      
      self.userviews = []
      if attrs['userviews'].size > 0
        attrs['userviews'].each do |view|
          self.userviews << GeoAPI::View.new({:name=>view, :guid=>self.guid})
        end
      end
      self.shorturl = attrs['shorturl']

      self
    end
      
    def type #type is a reserved word
      self.entity_type 
    end
    
    def update
      self.initialize(post("/e/#{guid}"))
    end
    
    def delete
      raise ArgumentError, "Object has no :guid" if self.guid.blank?
      begin
        Entity.destroy(:guid=>self.guid)
      rescue
        raise BadRequest, "There was a problem communicating with the API"
      end
      
    end
    
    def destroy
      self.delete
    end
    
    def save
      update
    end
    
    def to_s
      self.name
    end
    
    def to_json options=nil
      {:name=>name, :guid=>guid, :type=>entity_type, :geom=>geom, :views=>views, :userviews=>userviews, :shorturl=>shorturl}.to_json
    end
    
  end
end