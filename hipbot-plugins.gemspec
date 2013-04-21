# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hipbot-plugins/version'

Gem::Specification.new do |gem|
  gem.name          = "hipbot-plugins"
  gem.version       = Hipbot::Plugins::VERSION
  gem.authors       = ["Tomasz Pewiński"]
  gem.email         = ["pewniak747@gmail.com"]
  gem.description   = %q{A collection of plugins to use in your hipbot installation}
  gem.summary       = %q{A collection of plugins to use in your hipbot installation}
  gem.homepage      = "https://github.com/netguru/hipbot-plugins"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "hipbot"
end
