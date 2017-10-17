# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/recipe/scalaenv/version'

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-recipe-scalaenv"
  spec.version       = Itamae::Plugin::Recipe::Scalaenv::VERSION
  spec.authors       = ["Civitaspo"]
  spec.email         = ["civitaspo@gmail.com"]
  spec.summary       = %q{Itamae plugin to install scala with scalaenv}
  spec.description   = %q{Itamae plugin to install scala with scalaenv}
  spec.homepage      = "https://github.com/civitaspo/itamae-plugin-recipe-scalaenv"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "itamae", ">= 1.2"

  spec.add_development_dependency "bundler", ">= 1.7"
  spec.add_development_dependency "rake", ">= 10.0"
end
