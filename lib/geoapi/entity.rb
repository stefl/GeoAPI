module GeoAPI
  class Entity < GeoAPI::GeoObject
    
    attr_reader  :guid, :name, :type, :geom, :url, :latitude, :longitude, :views, :userviews, :raw_json
    
    alias_method :lat, :latitude 
    alias_method :lon, :longitude


    # Class methods
    
    
    def self.create(params)
      #required: name, geom
      #optional: pass id and it will create a new guid for you as user-<apikey>-<id>
      
      raise ArgumentError, "A name is required (pass :name in parameters)" unless params.has_key(:name)
      raise ArgumentError, "A geometry is required (pass :geom in parameters)" unless params.has_key(:geom)
      
      post_url = "/e" 
      post_url << "/user-#{APIKEY}-#{params[:id]}" unless params[:id].blank?

      Entity.new(post(post_url))
      
    end
    
    
    def self.find(*args)
      
      raise ArgumentError, "First argument must be symbol (:all or :get)" unless args.first.kind_of?(Symbol)
      
      params = args.extract_options!
      params = params == {} ? nil : params
      
      results = []
      
      filter = case args.first
      when :all
        'all'
      else
        raise ArgumentError, "Arguments should include a :guid" if params[:guid].blank?
        results = Entity.new(get("/e/#{params[:guid]}"))
      end
          
      results
      
    end
    
    # Instance methods
    def initialize(attrs)
      debugger
      #@raw_json = JSON.generate(attrs)
      @guid = attrs['guid']
      if attrs['meta']
        @name = attrs['meta']['name']
        @views = attrs['meta']['views'] || []
        @userviews = attrs['meta']['userviews'] || []
        @type = attrs['meta']['type'].to_sym
      end
      self
    end
    
    def update
      self.initialize(post("/e/#{guid}"))
    end
    
    def save
      update
    end
    
    def to_s
      self.name
    end
    
    def to_json
      self.raw_json
    end
    
    
  end
end