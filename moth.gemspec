$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "moth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "moth"
  s.version     = Moth::VERSION
  s.authors     = ["Rafael Barbosa"]
  s.email       = ["rbocosta@gmail.com"]
  s.homepage    = "https://github.com/escobera/moth"
  s.summary     = "Caterpillar for rails 3!"
  s.description = "Some changes to the caterpillar gem to make it work with rails 3"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "hpricot", ">= 0.6.164"
  # TODO: detect jruby
  s.add_dependency "jrexml"
  s.add_dependency "warbler"
  s.add_dependency "rake"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"
  s.add_development_dependency "jruby-openssl"
end
