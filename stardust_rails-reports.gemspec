lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "stardust_rails/reports/version"

Gem::Specification.new do |spec|
  spec.name          = "stardust_rails-reports"
  spec.version       = StardustRails::Reports::VERSION
  spec.authors       = ["Vic Amuso"]
  spec.email         = ["vic@parablesoft.com"]

  spec.summary       = "Stardust - Hooks module"
  spec.description   = "Stardust - Hooks module"
  spec.homepage      = "https://github.com/parablesoft/stardust_rails-reports"
  spec.license       = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  spec.add_dependency "rails", ">= 5.0.2"
  spec.add_dependency "stardust_rails"
  spec.add_dependency "pg"
  spec.add_development_dependency "byebug"
  # spec.add_development_dependency "rspec", "~> 3.0"
end
