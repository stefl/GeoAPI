%w{rubygems rest_client httparty}.each { |x| require x }
 
if defined?(ActiveSupport::JSON)
  JSON = ActiveSupport::JSON
  module JSON
    def self.parse(json)
      decode(json)
    end
  end
else
  require 'json'
end

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
  API_KEY     = "p4MIOnORr3"
  class << self
   attr_accessor :apikey
  end

  class BadRequest           < StandardError; end
  class NotFound             < StandardError; end
  class NotAcceptable        < StandardError; end
end

require 'geoapi/geo_object' 
require 'geoapi/version'
require 'geoapi/entity'
require 'geoapi/view'
require 'geoapi/query'
