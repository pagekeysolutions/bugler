lib = File.expand_path('../lib', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bugler/version'

Gem::Specification.new do |s|
  s.name        = 'bugler'
  s.version     = Bugler::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Sleek static site generator"
  s.description = "Bugler makes managing your blog or website easy via the command line."
  s.authors     = ["Steve Grice"]
  s.email       = 'steve@pagekeysolutions.com'
  s.executables = ["bugler"]
  s.homepage    =
    'http://rubygems.org/gems/bugler'
  s.license       = 'MIT'

  s.add_development_dependency "rspec", "~> 0"

  s.files       = Dir.glob("{bin,lib}/**/*") + %w(README.md)
  s.require_path = 'lib'
end
