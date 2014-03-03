# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hipbot-plugins/version'

Gem::Specification.new do |gem|
  gem.name          = "hipbot-plugins"
  gem.version       = Hipbot::Plugins::VERSION
  gem.authors       = ["Bartosz Kopiński", "Tomasz Pewiński"]
  gem.email         = ["bartosz.kopinski@gmail.com", "pewniak747@gmail.com"]
  gem.description   = %q{Hipbot sample plugins}
  gem.summary       = %q{A collection of plugins to use in your Hipbot installation}
  gem.homepage      = "https://github.com/netguru/hipbot-plugins"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "hipbot", '~> 1.0', '>= 1.0.0'
  gem.add_dependency 'cleverbot', '~> 0.2.0'
  gem.add_dependency 'htmlentities'
  gem.add_dependency 'wolfram', '~> 0.2.1'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
