$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_anonymize/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_anonymize"
  s.version     = RailsAdminAnonymize::VERSION
  s.authors     = ["Danijel Milisic"]
  s.email       = ["danijel.milisic@drap.hr"]
  s.homepage    = "http://www.drap.hr"
  s.summary     = "Anonymize records"
  s.description = "Enables anonymizing multiple records (which responds to .anonymize_all or #anonymize!) at once"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.1"
end
