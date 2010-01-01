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
    
    def initialize(api_key=nil)
      @api_key = api_key || ENV['GEOAPI_KEY']
    end
  
  end
end