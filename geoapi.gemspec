Gem::Specification.new do |s|
  s.name     = "steflewandowski-geoapi"
  s.version  = "0.2.1.1"
  s.date     = "2009-11-10"
  s.summary  = "A Ruby wrapper for the GeoAPI.com API."
  s.email    = "stef@stef.io"
  s.homepage = "http://github.com/steflewandowski/GeoAPI/"
  s.description = "A Ruby wrapper for the GeoAPI.com API based on the work of Chris Bruce. See http://api.geoapi.com for more information about the API."
  s.authors  = ["Stef Lewandowski","Chris Bruce"]
  
  s.files    = [
		"README",
		"LICENSE",
		"geoapi.gemspec", 
		"lib/geoapi.rb",
		"lib/geoapi/geo_object.rb",
		"lib/geoapi/geometry.rb",
		"lib/geoapi/query.rb",
		"lib/geoapi/entity.rb",
		"lib/geoapi/entry.rb",
		"lib/geoapi/view.rb",
		"lib/geoapi/user_view.rb",
		"lib/geoapi/version.rb",
    "lib/geoapi/client",
    "lib/geoapi/neighborhood"
	]
  
  s.add_dependency("rest-client",   [">= 0.9"])
  s.add_dependency("crack")
  s.add_dependency("httparty")
  s.add_dependency("uuidtools")

  
  s.has_rdoc = false
  s.rdoc_options = ["--main", "README.rdoc"]
end