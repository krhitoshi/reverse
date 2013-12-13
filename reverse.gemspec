# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reverse/version'

Gem::Specification.new do |spec|
  spec.name          = "reverse"
  spec.version       = Reverse::VERSION
  spec.authors       = ["Hitoshi Kurokawa"]
  spec.email         = ["hitoshi@nextseed.jp"]
  spec.description   = %q{reverse DNS lookup CLU for standard output}
  spec.summary       = %q{reverse DNS lookup CLU for standard output}
  spec.homepage      = "https://github.com/krhitoshi/reverse"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
