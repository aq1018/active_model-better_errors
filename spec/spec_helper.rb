# encoding: utf-8

# SimpleCov MUST be started before require 'rom-relation'
#
if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start do
    command_name 'spec:unit'

    add_filter 'config'
    add_filter 'lib/rom/support'
    add_filter 'spec'
  end
end

require 'active_model/better_errors'
require 'devtools/spec_helper'
