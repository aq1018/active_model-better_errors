# coding: utf-8

module ActiveModel
  module BetterErrors
    #
    # Abstract Formatter class
    class Formatter
      extend Forwardable

      def_delegators :@error_message, :attribute, :message, :options

      attr_reader :base, :error_message

      def initialize(base, error_message)
        @base, @error_message = base, error_message
      end

      #
      # @abstract
      # Formats the error message into a comsumable string.
      # see HumanMessageFormatter for more details.
      def format_message
      end
    end
  end
end
