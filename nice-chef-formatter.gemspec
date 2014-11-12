$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "nice-chef-formatter"
  s.version     = "0.0.4"
  s.authors     = ["Nadir Lloret"]
  s.email       = ["nadir.lloret@livedrive.com"]
  s.homepage    = "https://github.com/nadirollo/nice-chef-formatter"
  s.summary     = %q{Nice Chef log formatter}
  s.description = %q{Simple formatted output for chef with execution times and color for resource action results}

  s.rubyforge_project = "nice-chef-formatter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
