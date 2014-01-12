# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # ErrorMessageSet
    #
    class ErrorMessageSet < Array
      def initialize(base, attribute, errors = [])
        @base      = base
        @attribute = attribute
        errors.each do |error|
          push(*error)
        end
      end

      def <<(error)
        super ErrorMessage.build(@base, @attribute, *error)
      end

      def push(message, options = {})
        super ErrorMessage.build(@base, @attribute, message, options)
      end

      def []=(index, error)
        super index, ErrorMessage.build(@base, @attribute, *error)
      end

      def insert(index, error)
        super index, ErrorMessage.build(@base, @attribute, *error)
      end

      def to_a
        dup
      end
    end
  end
end
