# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'whydoiwork/version'

Gem::Specification.new do |spec|
  spec.name          = "whydoiwork"
  spec.version       = Whydoiwork::VERSION
  spec.authors       = ["Jan Dudek"]
  spec.email         = ["jd@jandudek.com"]
  spec.description   = %q{Why do I work?}
  spec.summary       = %q{Seriously? Why?}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "harvested", "~> 1.2.0"
  spec.add_dependency "activesupport", "~> 4.1.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
