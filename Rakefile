lib = File.expand_path("../lib", __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'rspec/core/rake_task'
require 'bugler/version'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :build do
  system 'gem build bugler.gemspec'
end

task :install => :build do
  system 'gem install bugler-' + Bugler::VERSION + '.gem'
end
