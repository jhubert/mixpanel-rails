# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mixpanel/rails/version'

Gem::Specification.new do |gem|
  gem.name          = "mixpanel-rails"
  gem.version       = Mixpanel::Rails::VERSION
  gem.authors       = ["Charles Lowell"]
  gem.email         = ["cowboyd@thefrontside.net"]
  gem.description   = %q{A Rails Engine for Mixpanel}
  gem.summary       = %q{Autoconfigure your Rails environment for use with Mixpanel}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rails', '~> 3.0'
  gem.add_dependency 'mixpanel', '~> 3.0'
end
