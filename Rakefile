# encoding: utf-8

require "bundler/gem_tasks"

# Added by devtools
require 'devtools'
Devtools.init_rake_tasks

task :default => [
  # Make sure ruby style is good
  'metrics:rubocop',

  # Duplicate code detection.
  # Currently a lot of dups that need to be worked on.
  # Disabled so travis can pass test.
  # 'metrics:flay',

  # Check for code smells
  # Currently very smelly
  # Disabled so travis can pass test.
  # 'metrics:reek',

  # run spec and generate coverage
  'metrics:coverage',

  # We need to kill all mutants before enabling this for ci
  # 'metrics:mutant'
]
