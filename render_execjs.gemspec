# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "render_execjs/version"

Gem::Specification.new do |s|
  s.name        = "render_execjs"
  s.version     = RenderExecJS::VERSION
  s.authors     = ["Tasveer Singh"]
  s.email       = ["taz@zenapsis.com"]
  s.homepage    = ""
  s.summary     = "Render JavaScript with Rails"
  s.description = "Execute server side JavaScript and render the result with Rails."

  s.rubyforge_project = "render_execjs"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rails", ">= 3.1.3"
  s.add_runtime_dependency "execjs"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "coffee-script"
  s.add_development_dependency "appraisal"
end
