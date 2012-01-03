# encoding: UTF-8
require 'rubygems'
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rake'
require 'rdoc/task'
require 'rspec/core/rake_task'

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SummitMisc'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

RSpec::Core::RakeTask.new(:test) do |spec|
  spec.pattern = 'test/*_spec.rb'
  spec.rspec_opts = ['--backtrace', '--color']
end

task :default => :test

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
