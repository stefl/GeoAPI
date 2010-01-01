module GeoAPI
  class GeoObject
    
    include HTTParty
    
    format :json
    
    class << self
      attr_accessor :api_key
    end
    
    default_params :apikey => api_key
    
    #default_params Proc.new { :apikey => api_key} } 
    
    base_uri GeoAPI::API_URL
    
    # Allow users to set the API key explicitly, or gain it from other sources. 
    # Makes for more readable code, and allows multiple keys to be used in the one application.
    
    def initialize(attrs)
      #raise ArgumentError, "A :client must be passed to when creating a GeoObject, unless unless ENV['GEOAPI_KEY'] or is set"
      
      self.api_key = attrs[:client].api_key if attrs.has_key?(:client)
      self.api_key ||= attrs[:apikey] if attrs.has_key?(:apikey)
      self.api_key ||= attrs[:api_key] if attrs.has_key?(:api_key)
      self.api_key ||= attrs[:api_key] if attrs.has_key?(:api_key)
      self.api_key ||= self.class.get_api_key
      
      class << self
        default_params :apikey => self.api_key
      end
    end
    
    def self.get_api_key 
      the_api_key ||= GEO_APIKEY
      the_api_key ||= ENV["GEOAPI_KEY"]
    end
    
    
    
  end
  
end