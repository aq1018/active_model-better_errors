# encoding: utf-8

require 'abstract_type'
require 'concord'
require 'active_support'
require 'active_support/core_ext'
require 'active_model'

require 'active_model/better_errors/constants'
require 'active_model/better_errors/helper'
require 'active_model/better_errors/error_message'
require 'active_model/better_errors/error_message/builder'
require 'active_model/better_errors/error_message_set'
require 'active_model/better_errors/error_collection'

require 'active_model/better_errors/formatter'
require 'active_model/better_errors/formatter/human'
require 'active_model/better_errors/formatter/human/builder'
require 'active_model/better_errors/formatter/human/builder/attribute'
require 'active_model/better_errors/formatter/human/builder/keys'
require 'active_model/better_errors/formatter/human/builder/options'
require 'active_model/better_errors/formatter/human/builder/value'
require 'active_model/better_errors/formatter/human/translator'
require 'active_model/better_errors/formatter/human/translator/attribute'
require 'active_model/better_errors/formatter/human/translator/message'
require 'active_model/better_errors/formatter/human/translator/full_message'

require 'active_model/better_errors/formatter/machine'

require 'active_model/better_errors/reporter'
require 'active_model/better_errors/reporter/message'
require 'active_model/better_errors/reporter/hash'
require 'active_model/better_errors/reporter/array'

require 'active_model/better_errors/emulation'
require 'active_model/better_errors/errors'
require 'active_model/better_errors/registry'
require 'active_model/better_errors/version'

# :nodoc:
module ActiveModel
  # Note:
  #
  # This lib references `ActiveModel::StrictValidationFailed`, and this class
  # will only become available when `ActiveModel::Errors` is autoloaded.
  # The `Errors` line below forces `ActiveModel::StrictValidationFailed`
  # to be loaded, and consequently breaks rubocop, thus the rubocop inline
  # instructions...
  #
  # rubocop:disable Void
  Errors
  # rubocop:enable Void

  #
  # BetterErrors
  #
  module BetterErrors
    class << self
      attr_accessor :default_formatter_type

      def reporters
        @reporters ||= Registry.new
      end

      def formatters
        @formatters ||= Registry.new
      end

      def default_formatter_class
        formatters[default_formatter_type]
      end

      def reporter_types
        REPORTER_TYPES
      end
    end

    reporters
      .register(:array, Reporter::Array)
      .register(:hash, Reporter::Hash)
      .register(:message, Reporter::Message)

    formatters
      .register(:human, Formatter::Human)
      .register(:machine, Formatter::Machine)

    self.default_formatter_type = :human
  end
end

# Overrides ActiveSupport::Validation#errors here
require 'active_model/better_errors/hook'
