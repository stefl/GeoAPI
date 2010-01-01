module GeoAPI
  class GeoObject
    
    include HTTParty
    
    format :json
    
    class << self
      attr_accessor :apikey
    end
    
    default_params :apikey => GeoAPI.api_key
    base_uri GeoAPI::API_URL
    
    def initialize(attrs)
      #raise ArgumentError, "A :client must be passed to when creating a GeoObject, unless unless ENV['GEOAPI_KEY'] or is set"
      @apikey = attrs[:client]
    end
    
  end
  
end