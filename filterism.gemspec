# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filterism/version'

Gem::Specification.new do |spec|
  spec.name          = "filterism"
  spec.version       = Filterism::VERSION
  spec.authors       = ["Phil Spitler"]
  spec.email         = ["pspitler@gmail.com"]
  spec.summary       = "DSL for communicating filter intent via HTTP parameters in the URL"
  spec.description   = ""
  spec.homepage      = "http://sproutkey.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bond"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "activerecord"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "factory_girl", "~> 4.0"
end
