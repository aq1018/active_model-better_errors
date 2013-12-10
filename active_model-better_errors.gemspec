# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model/better_errors/version'

Gem::Specification.new do |spec|
  spec.name          = "active_model-better_errors"
  spec.version       = ActiveModel::BetterErrors::VERSION
  spec.authors       = ["Aaron Qian", "Byron Anderson"]
  spec.email         = ["aq1018@gmail.com", "byronanderson32@gmail.com"]
  spec.description   = "API consumable error messages with ActiveModel::Errors drop-in compatibility."
  spec.summary       = "active_model-better_errors is a ActiveModel::Errors compatible library to help you customize the presentation of your error messages."
  spec.homepage      = "http://github.com/aq1018/active_model-better_errors"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "active_model", ">= 3.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.12.0"
  spec.add_development_dependency "mocha", '>= 0.12.1'
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "rdoc"
end


