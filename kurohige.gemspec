# -*- encoding: utf-8 -*-
require File.expand_path('../lib/kurohige/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["mizoryu"]
  gem.email         = ["suzunatsu@yahoo.com"]
  gem.description   = %q{description}
  gem.summary       = %q{summary}
  gem.homepage      = "https://github.com/mizoR/kurohige"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "kurohige"
  gem.require_paths = ["lib"]
  gem.version       = Kurohige::VERSION
end
