$:.push File.expand_path("../lib", __FILE__)

require "mournful_settings/version"

Gem::Specification.new do |s|
  s.name        = "mournful_settings"
  s.version     = MournfulSettings::VERSION
  s.authors     = ["Rob Nichols"]
  s.email       = ["rob@undervale.co.uk"]
  s.homepage    = "https://github.com/reggieb/mournful_settings"
  s.summary     = "Tool for adding encrypted settings to an app."
  s.description = "Packages up code needed to pull data from YAML files when seeding, and adds a process log."

  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  
  s.add_dependency 'activerecord'
  s.add_development_dependency 'sqlite3'
end