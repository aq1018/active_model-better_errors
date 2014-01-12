# encoding: utf-8

require 'forwardable'
require 'active_support/all'
require 'active_model'

require 'active_model/better_errors/error_message'
require 'active_model/better_errors/error_message_set'
require 'active_model/better_errors/error_collection'

require 'active_model/better_errors/formatter'
require 'active_model/better_errors/human_message_formatter'

require 'active_model/better_errors/reporter'
require 'active_model/better_errors/message_reporter'
require 'active_model/better_errors/hash_reporter'
require 'active_model/better_errors/array_reporter'

require 'active_model/better_errors/human_message_reporter'
require 'active_model/better_errors/human_hash_reporter'
require 'active_model/better_errors/human_array_reporter'

require 'active_model/better_errors/machine_hash_reporter'
require 'active_model/better_errors/machine_array_reporter'

require 'active_model/better_errors/emulation'
require 'active_model/better_errors/errors'

module ActiveModel
  #
  # BetterErrors
  #
  module BetterErrors
    class << self
      attr_accessor :formatter

      def set_reporter(name, reporter)
        name = name.to_s
        @reporter_maps ||= {}
        return @reporter_maps.delete(name) unless reporter
        @reporter_maps[name] = get_reporter_class(name, reporter)
      end

      def reporters
        @reporter_maps ||= {}
        @reporter_maps.clone
      end

      def get_reporter_class(name, reporter)
        return reporter if reporter.is_a? Class
        class_name = "#{reporter}_#{name}_reporter"
        "active_model/better_errors/#{class_name}".classify.constantize
      end

      def format_message(base, message)
        formatter.new(base, message).format_message
      end
    end

    set_reporter :message,  :human
    set_reporter :array,    :human
    set_reporter :hash,     :human

    self.formatter = HumanMessageFormatter
  end

  #
  # ActiveModel::Validations.errors override
  #
  module Validations
    def errors
      @errors ||= BetterErrors::Errors.new(self)
    end
  end
end
