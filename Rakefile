# encoding: UTF-8
require 'rubygems'
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')

task :default => :spec

desc 'Initial project setup'
task :setup do
  system 'bundle install'
  puts 'Setup completed.'
end

desc 'Build the project'
task :build do
  system 'gem build summit-misc.gemspec'
  puts 'Built.'
end

desc "Deploy"
task :deploy do
  puts "Not yet implemented."
  puts "The gem should be deployed to the gemserver."
end
