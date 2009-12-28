module GeoAPI
  class GeoObject
    
    include HTTParty
    
    format :json
  
    base_uri GeoAPI::API_URL
    default_params :apikey => GeoAPI.apikey
    
  end
  
end