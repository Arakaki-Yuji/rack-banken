# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/banken/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-banken"
  spec.version       = Rack::Banken::VERSION
  spec.authors       = ["Arakaki Yuji"]
  spec.email         = ["arakaki@ryukyu-i.co.jp"]
  spec.summary       = %q{rack-banken is rack application for return error response.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rack", "~> 1.6.0"
  spec.add_runtime_dependency "json", "~> 1.7"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", "~> 3.0.0"
  spec.add_development_dependency "activesupport", "~> 4.2.0"
end
