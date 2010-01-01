GEO_APIKEY = "p4MIOnORr3"

%w{rubygems rest_client httparty json crack/json}.each { |x| require x }

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

  class ArgumentError        < StandardError; end
  class BadRequest           < StandardError; end
  class NotFound             < StandardError; end
  class NotAcceptable        < StandardError; end
end


$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
require 'geoapi/geo_object' 
require 'geoapi/geometry' 
require 'geoapi/version'
require 'geoapi/entity'
require 'geoapi/entry'
require 'geoapi/view'
require 'geoapi/user_view'
require 'geoapi/query'
