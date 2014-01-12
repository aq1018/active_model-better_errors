# encoding: utf-8

require 'forwardable'
require 'active_support/all'
require 'active_model'
require 'active_model/error_collecting'

module ActiveModel
  #
  # ActiveModel::Validations.errors override
  #
  module Validations
    def errors
      @errors ||= ErrorCollecting::Errors.new(self)
    end
  end
end
