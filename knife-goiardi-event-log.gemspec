# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knife-goiardi-event-log/version'

Gem::Specification.new do |spec|
  spec.name          = "knife-goiardi-event-log"
  spec.version       = Knife::GoiardiEventLog::VERSION
  spec.authors       = ["ctdk"]
  spec.email         = ["jbingham@gmail.com"]
  spec.summary       = %q{Knife plugin for viewing goiardi's event log.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/ctdk/knife-goiardi-event-log"
  spec.license       = "apache2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
