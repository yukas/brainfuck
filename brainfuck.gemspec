# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brainfuck/version'

Gem::Specification.new do |spec|
  spec.name          = "brainfuck"
  spec.version       = Brainfuck::VERSION
  spec.authors       = ["Yuri Kaspervich"]
  spec.email         = ["ykas.gg@gmail.com"]

  spec.summary       = %q{Brainfuck interpreter in Ruby}
  spec.description   = %q{TDD'ing creation of Brainfuck interpreter in Ruby}
  spec.homepage      = "https://github.com/yukas/brainfuck"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
