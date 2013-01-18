require 'forwardable'
require 'active_model/error_collecting'

require 'active_model/error_collecting/error_message'
require 'active_model/error_collecting/error_message_set'
require 'active_model/error_collecting/error_collection'

require 'active_model/error_collecting/human_message_formatter'
require 'active_model/error_collecting/human_message_reporter'
require 'active_model/error_collecting/human_hash_reporter'
require 'active_model/error_collecting/human_array_reporter'

require 'active_model/error_collecting/emulation'
require 'active_model/error_collecting/errors'

require 'active_model/validations'

module ActiveModel
  module Validations
    def errors
      @errors ||= ErrorCollecting::Errors.new(self)
    end
  end
end
