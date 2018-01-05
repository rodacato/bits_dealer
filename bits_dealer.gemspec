
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

  spec.files         = `git ls-files`.split($\)
  spec.bindir        = "exe"
  spec.executables   = ["bits_dealer"]
  spec.require_paths = ["lib"]

  spec.add_dependency 'bitsor', "~> 0.1.2"
  spec.add_dependency 'money'
  spec.add_dependency 'parallel'
  spec.add_dependency 'retries'
  spec.add_dependency 'sequel'
  spec.add_dependency 'sqlite3'
  spec.add_dependency 'terminal-table'
  spec.add_dependency 'tty-prompt'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
