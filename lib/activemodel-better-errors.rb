require 'active_model/validations'
require 'active_model/error_collecting/hash_reporter'
require 'active_model/error_collecting/human_reporter'
require 'active_model/error_collecting/error_collection'
require 'active_model/error_collecting/error_message'
require 'active_model/error_collecting/error_message_set'
require 'active_model/error_collecting/errors'
require 'active_model/better_errors'

module ActiveModel
  module Validations
    def errors
      @errors ||= ErrorCollecting::Errors.new(self)
    end
  end
end
