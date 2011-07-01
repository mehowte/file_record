# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "file_record"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michał Taszycki"]
  s.homepage    = "https://github.com/mehowte/file_record"
  s.description = "Insert FileRecord description."
  s.summary     = %q{Simplistic implementation of persistent model library. }
  s.description = %q{Simplistic implementation of persistent model library. Inspired by ActiveRecord. And fully compatible with ActiveModel.}
  s.rubyforge_project = "file_record"
  
  s.add_dependency "rails", "~> 3.0.4"
  s.add_development_dependency "capybara"
  s.add_development_dependency "sqlite3-ruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.version = "0.0.1"
end
