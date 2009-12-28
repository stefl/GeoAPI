module GeoAPI
  class View
    
    attr_accessor :name, :guid, :view_type
    
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
        response = get("/e/#{params[:guid]}/#{params[:name]}")
      rescue
        raise BadRequest, "There was a problem communicating with the API"
      end
    
      results = View.new(response['result'].merge({'guid'=>params[:guid]})) unless response['result'].blank? #the api doesn't return a guid in json?!

      results
    end
    
    # Instance methods
    def initialize attrs
      
    end
  end
  
end
