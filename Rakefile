# encoding: utf-8

require "bundler/gem_tasks"

# Added by devtools
require 'devtools'
Devtools.init_rake_tasks

task :default => [
  'metrics:coverage',
  'metrics:rubocop',
  'metrics:flay',
  # 'metrics:reek',
  'spec:integration'
  # 'metrics:mutant'
]
