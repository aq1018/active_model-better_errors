# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # ErrorMessageSet
    #
    class ErrorMessageSet < Array
      attr_reader :base, :attribute

      def initialize(base, attribute, errors = [])
        @base      = base
        @attribute = attribute
        errors.each { |error| push(*error) }
      end

      def <<(error)
        super build_error_message(*error)
      end

      def push(message, options = nil)
        super build_error_message(message, options)
      end

      def insert(index, error)
        super index, build_error_message(*error)
      end
      alias_method :[]=, :insert

      def to_a
        dup
      end

      private

      def build_error_message(error, options = nil)
        ErrorMessage::Builder.build(base, attribute, error, options)
      end
    end
  end
end
