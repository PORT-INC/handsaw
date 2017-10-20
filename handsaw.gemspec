$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "handsaw/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "handsaw"
  s.version     = Handsaw::VERSION
  s.authors     = ["sho ishihara"]
  s.email       = ["sho.ishihara@theport.jp"]
  s.homepage    = "https://github.com/PORT-INC/handsaw"
  s.summary     = "Handsaw is a new lightweight markup language made in Ruby"
  s.description = "Handsaw is a new lightweight markup language made in Ruby"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"
  s.add_dependency "nokogiri"
  s.add_dependency 'redcarpet', '~> 3.3.4'
  s.add_dependency 'html-pipeline', '~> 2.4.2'

  s.add_development_dependency "sqlite3"
end
