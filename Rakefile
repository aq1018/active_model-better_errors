# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "activemodel-better-errors"
  gem.homepage = "http://github.com/aq1018/activemodel-better-errors"
  gem.license = "MIT"
  gem.summary = %Q{ActiveModel::Errors class is not designed for API consumption. This gem allows for that while keeping compatibility with existing rails API.}
  gem.description = %Q{ActiveModel::Errors class is not designed for API consumption. This gem allows for that while keeping compatibility with existing rails API.}
  gem.email = ["aq1018@gmail.com", "byronanderson32@gmail.com"]
  gem.authors = ["Aaron Qian", "Byron Anderson"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

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
