$:.push File.expand_path("../lib", __FILE__)

require "same_as/version"

Gem::Specification.new do |s|
  s.name        = 'same_as'
  s.version     = SameAs::VERSION
  s.summary     = "SameAs"
  s.description = "Compares two objects and recturns a percentage amount inidcating their sameness"
  s.authors     = ["Daybear, Inc."]
  s.email       = 'engineering@daybear.com'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/daybear/same_as'
  s.license     = 'MIT'
end
