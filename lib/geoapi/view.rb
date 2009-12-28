module GeoAPI
  class View < GeoAPI::GeoObject
    
    attr_accessor :name, :guid, :view_type, :id
    
    @path_prefix = "view"
    
    # Class methods
    def self.find(*args)
      
      #raise ArgumentError, "First argument must be symbol (:all or :get)" unless args.first.kind_of?(Symbol)
      
      params = args.extract_options!
      params = params == {} ? nil : params
      
      results = nil
      params[:guid] = "user-#{GeoAPI::API_KEY}-#{params[:id]}" unless params[:id].blank?
      raise ArgumentError, "Arguments should include a entity :guid or an :id" if params[:guid].blank? && params[:id].blank?
      raise ArgumentError, "Arguments should include a view :name" if params[:name].blank?
      
      begin
        response = get("/e/#{params[:guid]}/#{path_prefix}/#{params[:name]}")
      rescue
        raise BadRequest, "There was a problem communicating with the API"
      end
    
      results = View.new(response['result'].merge({'guid'=>params[:guid], 'name'=>params[:name]})) unless response['result'].blank? #the api doesn't return a guid in json?!

      results
    end
    
    
    # Instance methods
    def initialize attrs
      self.name = attrs['name']
      self.guid = attrs['guid']
      self.view_type = attrs['type']
      
    end
    
    
    def load
      raise ArgumentError, "Properties should include a .guid or .id" if params[:guid].blank? && params[:id].blank?
      raise ArgumentError, "Properties should include a .name" if self.name.blank?
      
      begin
        response = get("/e/#{self.guid}/#{path_prefix}/#{self.name}")
      rescue
        raise BadRequest, "There was a problem communicating with the API"
      end
    
      self.initialize(response['result'].merge({'guid'=>self.guid, 'name'=>self.name, })) unless response['result'].blank? #the api doesn't return a guid in json?!
      
    end
    
    def to_json options=nil
      {:name=>name, :guid=>guid, :type=>view_type}.to_json
    end
  end

end
