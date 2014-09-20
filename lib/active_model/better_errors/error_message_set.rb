# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # Represents a set of ErrorMessages.
    # It can convert various error representations (strings, symbols, or both)
    # into ErrorMessage objects by using ErrorMessage::Builder
    #
    class ErrorMessageSet < Array
      attr_reader :base, :attribute

      def initialize(base, attribute, errors = nil)
        @base      = base
        @attribute = attribute
        push(*errors)
      end

      def []=(pos, error)
        super pos, build_error_message(error)
      end

      def <<(error)
        error_message = build_error_message(error)
        super(error_message)
      end

      def push(*args)
        errors = args.map { |error| build_error_message(error) }
        super(*errors)
      end

      def insert(index, *args)
        errors = args.map { |error| build_error_message(error) }
        super(index, *errors)
      end

      def to_a
        dup
      end

      private

      def build_error_message(error)
        return error if error.is_a?(ErrorMessage)

        if error.is_a?(Hash)
          message, options = error.delete(:type), error
        elsif error.is_a?(Symbol) || error.is_a?(String)
          message = error
        else
          fail ArgumentError, 'error must be a hash, symbol, or string.'
        end
        ErrorMessage::Builder.build(base, attribute, message, options)
      end
    end
  end
end
