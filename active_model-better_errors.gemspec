# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model/better_errors/version'

Gem::Specification.new do |gem|
  gem.name          = "active_model-better_errors"
  gem.version       = ActiveModel::BetterErrors::VERSION
  gem.authors       = ["Aaron Qian", "Byron Anderson"]
  gem.email         = ["aq1018@gmail.com", "byronanderson32@gmail.com"]
  gem.description   = "API consumable error messages with ActiveModel::Errors drop-in compatibility."
  gem.summary       = "active_model-better_errors is a ActiveModel::Errors compatible library to help you customize the presentation of your error messages."
  gem.homepage      = "http://github.com/aq1018/active_model-better_errors"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "activemodel",         ">= 3.0"
  gem.add_dependency 'concord',             '~> 0.1.4'
  gem.add_dependency 'abstract_type',       '~> 0.0.6'
  gem.add_dependency 'adamantium',          '~> 0.1'
end


