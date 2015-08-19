# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails2_ruby2/version'

Gem::Specification.new do |spec|
  spec.name          = "rails2_ruby2"
  spec.version       = Rails2Ruby2::VERSION
  spec.authors       = ["Andrew Warner"]
  spec.email         = ["wwarner.andrew@gmail.com"]

  spec.summary       = %q{Write a short summary, because Rubygems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = "http://doesntexistrightnow.edu"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"

  if RUBY_VERSION >= '2.0'
    spec.add_dependency "syck", "~> 1.0.5"
    spec.add_dependency 'iconv'
    spec.add_dependency 'test-unit', '1.2.3'
  end
end
