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

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 5.0.2"
  spec.add_dependency "stardust_rails"
  spec.add_dependency "pg"
  spec.add_development_dependency "byebug"
  # spec.add_development_dependency "rspec", "~> 3.0"
end
