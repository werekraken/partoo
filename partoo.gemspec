# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'partoo/version'

Gem::Specification.new do |s|
  s.name          = "partoo"
  s.version       = Partoo::VERSION
  s.authors       = ["matt.cover"]
  s.email         = ["werekraken@gmail.com"]

  s.summary       = "Do cool things with par2 files."
  s.description   = "Partoo parses data from par2 files allowing programmatic access."
  s.homepage      = "https://github.com/werekraken/partoo"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "bindata"
  s.add_dependency "thor"

  s.add_development_dependency "aruba"
  s.add_development_dependency "bundler", "~> 1.14"
  s.add_development_dependency "cucumber"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"
end
