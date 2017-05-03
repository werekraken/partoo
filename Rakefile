require "bundler/gem_tasks"
require 'cucumber/rake/task'
require "rspec/core/rake_task"

Cucumber::Rake::Task.new(:features)

RSpec::Core::RakeTask.new(:spec)

desc 'Run spec and features'
task :test => [
  :spec,
  :features,
]

task :default => :test
