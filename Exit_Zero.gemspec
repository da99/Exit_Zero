# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require "Exit_Zero/version"

Gem::Specification.new do |s|
  s.name        = "Exit_Zero"
  s.version     = Exit_Zero::VERSION
  s.authors     = ["da99"]
  s.email       = ["i-hate-spam-45671204@mailinator.com"]
  s.homepage    = "https://github.com/da99/Exit_0"
  s.summary     = %q{Obsolete. Use 'Exit_0' gem instead.}
  s.description = %q{
    Obsolete. Use gem 'Exit_0' instead.
  }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bacon"
  s.add_development_dependency "rake"
  s.add_development_dependency 'Bacon_Colored'
  s.add_development_dependency 'pry'
  
  # s.rubyforge_project = "Exit_Zero"
  # specify any dependencies here; for example:
  s.add_runtime_dependency "Exit_0"
end
