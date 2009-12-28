%w{rubygems rest_client httparty crack/json}.each { |x| require x }

class Array
  # Extract options from a set of arguments. Removes and returns the last element in the array if it's a hash, otherwise returns a blank hash.
  #
  #   def options(*args)
  #     args.extract_options!
  #   end
  #
  #   options(1, 2)           # => {}
  #   options(1, 2, :a => :b) # => {:a=>:b}
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end
end

module GeoAPI
  API_VERSION = "v1"
  API_URL     = "http://api.geoapi.com/#{API_VERSION}/"
  API_KEY = "p4MIOnORr3"
  #API_KEY should be set elsewhere
  
  class << self
   attr_accessor :apikey
  end

  class ArgumentError        < StandardError; end
  class BadRequest           < StandardError; end
  class NotFound             < StandardError; end
  class NotAcceptable        < StandardError; end
end


dir = Pathname(__FILE__).dirname.expand_path.to_s

require dir + '/geoapi/geo_object' 
require dir + '/geoapi/geometry' 
require dir + '/geoapi/version'
require dir + '/geoapi/entity'
require dir + '/geoapi/entry'
require dir + '/geoapi/view'
require dir + '/geoapi/user_view'
require dir + '/geoapi/query'
