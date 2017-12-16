
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bits_dealer/version"

Gem::Specification.new do |spec|
  spec.name          = "bits_dealer"
  spec.version       = BitsDealer::VERSION
  spec.authors       = ["Adrian Castillo"]
  spec.email         = ["rodacato@gmail.com"]

  spec.summary       = %q{Another gem REPL to manage your bitso account}
  spec.description   = %q{Another gem REPL to manage your bitso account}
  spec.homepage      = "https://github.com/rodacato/bits_dealer"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files`.split($\)
  spec.bindir        = "exe"
  spec.executables   = ["bits_dealer"]
  spec.require_paths = ["lib"]

  spec.add_dependency 'bitsor'
  spec.add_dependency 'terminal-table'
  spec.add_dependency 'highline'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
