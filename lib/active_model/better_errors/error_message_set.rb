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
        super ErrorMessage::Builder.build(@base, @attribute, *error)
      end

      def push(message, options = {})
        super ErrorMessage::Builder.build(@base, @attribute, message, options)
      end

      def []=(index, error)
        super index, ErrorMessage::Builder.build(@base, @attribute, *error)
      end

      def insert(index, error)
        super index, ErrorMessage::Builder.build(@base, @attribute, *error)
      end

      def to_a
        dup
      end
    end
  end
end
