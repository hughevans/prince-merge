# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "prince_merge"
  gem.version       = "0.0.1"
  gem.authors       = ["Hugh Evans"]
  gem.email         = ["hugh@artpop.com.au"]
  gem.description   = %q{A mail merge for developers.}
  gem.summary       = %q{A mail merge for developers.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('haml', '>= 3.0.0')
  gem.add_dependency('sass', '>= 3.0.0')
  gem.add_dependency('prince-ruby', '>= 0.0.0')
end
