# encoding: utf-8

require "bundler/gem_tasks"

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

dir = File.dirname(__FILE__)

require 'rake/testtask'

test_files = []
test_files << "test/integration"
test_files += Dir.glob("#{dir}/vendor/rails/activemodel/test/cases/**/*_test.rb").sort

Rake::TestTask.new("test:integration") do |t|
  t.libs << "vendor/rails/activemodel/test"
  t.test_files = test_files
  t.warning = true
end


task :default => [ :spec ]

require 'yard'
YARD::Rake::YardocTask.new
