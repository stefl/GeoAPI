module GeoAPI
  class GeoObject
    
    include HTTParty
    
    format :json
    
    class << self
      attr_accessor :api_key
    end
    
    #default_params Proc.new { :apikey => api_key} } 
    
    base_uri GeoAPI::API_URL
    
    # Allow users to set the API key explicitly, or gain it from other sources. 
    # Makes for more readable code, and allows multiple keys to be used in the one application.
    
    def initialize(attrs)
      #raise ArgumentError, "A :client must be passed to when creating a GeoObject, unless unless ENV['GEOAPI_KEY'] or is set"
      
      @api_key = self.class.api_key_from_parameters(attrs)
      
    end
    
    def self.api_key 
      @api_key ||= GeoAPI::GEOAPI_KEY
      @api_key ||= ENV["GEOAPI_KEY"]
      puts "API KEY: #{@api_key}"
      @api_key
    end
    
    def self.api_key_from_parameters(attrs)
      unless attrs.blank?
        the_api_key = attrs[:client].api_key if attrs.has_key?(:client)
        the_api_key ||= attrs[:apikey] if attrs.has_key?(:apikey)
        the_api_key ||= attrs[:api_key] if attrs.has_key?(:api_key)
        the_api_key ||= attrs[:api_key] if attrs.has_key?(:api_key)
      end
      the_api_key ||= self.api_key
      puts "API Key from parameters: #{the_api_key}"
      @api_key = the_api_key
      the_api_key
    end
    
    def self.post path, options={}
      puts "Post: #{path} : #{options.to_s}"
      timeout = options[:timeout] || 2
      options.delete(:timeout)
      retryable( :tries => 2 ) do
        Timeout::timeout(timeout) do |t|
          super path, options
        end
      end
    end
    
    def self.get path, options={}
      puts "Get: #{path} : #{options.to_s}"
      timeout = options[:timeout] || 2
      debugger
      options.delete(:timeout)
      puts options.to_s
      puts "Timeout #{timeout}"
      retryable( :tries => 2 ) do
        Timeout::timeout(timeout) do |t|
          super path, options
        end
      end
    end
    
    def self.delete path, options={}
      puts "Delete: #{path} : #{options.to_s}"
      timeout = options[:timeout] || 2
      options.delete(:timeout)
      retryable( :tries => 2 ) do
        Timeout::timeout(timeout) do |t|
          super path, options
        end
      end
    end
    
  end
  
end