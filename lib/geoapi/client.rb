module GeoAPI
  class Client

    # To connect to GeoAPI, either:
    #
    # Add export GEOAPI_KEY=<your-api-key> in your .bashrc file
    # 
    # @client = GeoAPI::Client.new
    #
    # OR
    #
    # @client = GeoAPI::Client.new('<your-api-key>')  
    #
    # OR set GEOAPI_KEY='<your-api-key>' before including GeoAPI
    #
    # @client = GeoAPI::Client.new
    
    def initialize(api_key=nil)
      @api_key = api_key || ENV['GEOAPI_KEY'] || GEOAPI_KEY
    end
    
    def api_key
      @api_key
    end
  
  end
end