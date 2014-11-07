$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "nice-chef-formatter"
  s.version     = "0.0.1"
  s.authors     = ["Nadir Lloret"]
  s.email       = ["nadir.lloret@livedrive.com"]
  s.homepage    = "https://github.com/nadirollo/nice_chef_formatter"
  s.summary     = %q{Nice Chef log formatter}
  s.description = %q{Clean and simple output with execution times.}

  s.rubyforge_project = "nice-chef-formatter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end