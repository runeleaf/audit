$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "audit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name          = "audit"
  s.version       = Audit::VERSION
  s.authors       = ["RAWHIDE. Co., Ltd."]
  s.email         = ["info@raw-hide.co.jp"]
  s.homepage      = "https://github.com/runeleaf/audit"
  s.summary       = "Summary of Audit."
  s.description   = "Description of Audit."

  s.files         = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.require_paths = ["lib"]

  s.add_development_dependency  "bundler"
  s.add_development_dependency  "rake"
  s.add_development_dependency  "rspec"
  s.add_development_dependency  "pry-rails"
  s.add_development_dependency  "activerecord-sqlserver-adapter"
  s.add_development_dependency  "sqlite3"

  s.add_dependency "rails", "~>   4.0.0.beta1"
  s.add_dependency "activesupport", "~>   4.0.0.beta1"
  s.add_dependency "activerecord", "~>   4.0.0.beta1"
end
