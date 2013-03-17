# -*- encoding: utf-8 -*-
require File.expand_path('../lib/machineshop/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["machineshop"]
  gem.email         = ["john@mach19.com"]
  gem.description   = %q{Wraps the machineshop API.}
  gem.summary       = %q{A convenient way to call into the machineshop API.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "machineshop"
  gem.require_paths = ["lib"]
  gem.version       = MachineShop::VERSION
  
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
    
  gem.add_dependency 'addressable'
  gem.add_dependency 'rest-client'#, '~> 1.6.7'
  gem.add_dependency('multi_json', '>= 1.0.4', '< 2')
end
