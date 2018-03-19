lib = File.expand_path("../lib", __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'rspec/core/rake_task'
require 'bugler/version'

RSpec::Core::RakeTask.new(:spec)

BUILT_GEM = 'bugler-' + Bugler::VERSION + '.gem'

task :default => :spec

task :build do
  system 'gem build bugler.gemspec'
end

task :install => :build do
  system 'gem install ' + BUILT_GEM

end

task :publish => :build do
  system 'gem push ' + BUILT_GEM
  system 'git tag -a ' + Bugler::VERSION + ' -m "Version ' + Bugler::VERSION + '"'
  system 'git push --tags'
end

task :clean do
  system 'rm *.gem'
end
