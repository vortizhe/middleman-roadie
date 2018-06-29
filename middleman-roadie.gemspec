# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "middleman-roadie/version"

Gem::Specification.new do |s|
  s.name        = "middleman-roadie"
  s.version     = Middleman::Roadie::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Victor Ortiz"]
  s.email       = ["kespers@gmail.com"]
  s.homepage    = "https://github.com/vortizhe/middleman-roadie"
  s.summary     = %q{Roadie Middleman extension adaptor}
  s.description = %q{Automatize email inlining css with roadie}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 4.1.2"])

  # Additional dependencies
  s.add_runtime_dependency("roadie", ["~> 3.3.0"])
end
