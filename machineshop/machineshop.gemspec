# -*- encoding: utf-8 -*-
require File.expand_path('../lib/machineshop/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["John Cox"]
  gem.email         = ["john@mach19.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "machineshop"
  gem.require_paths = ["lib"]
  gem.version       = Machineshop::VERSION
end
