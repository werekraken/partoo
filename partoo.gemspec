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
  s.description   = "Partoo parses data from par2 files allowing programatic access."
#  s.homepage      = "N/A"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

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
