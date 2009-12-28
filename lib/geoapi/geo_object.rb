module GeoAPI
  class GeoObject
    
    include HTTParty
    
    format :json
    
    class << self
      attr_accessor :apikey
    end
    
    default_params :apikey => GeoAPI::API_KEY
    base_uri GeoAPI::API_URL
    
    
  end
  
end