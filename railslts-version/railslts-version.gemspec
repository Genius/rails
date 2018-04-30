# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'railslts-version'

Gem::Specification.new do |spec|
  spec.name          = "railslts-version"
  spec.version       = RailsLts::VERSION::STRING
  spec.authors       = ["Arne Hartherz"]
  spec.email         = ["arne.hartherz@makandra.de"]
  spec.summary       = "Gem to track your current Rails LTS version."
  spec.description   = "Note that this gem will neither install nor upgrade Rails LTS for you. Visit https://railslts.com/ to find out more about Rails LTS."
  spec.homepage      = "https://railslts.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
