# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # ErrorMessage
    #
    class ErrorMessage
      include Helper, Comparable

      attr_reader :base, :attribute, :type, :message, :options

      def initialize(base, attribute, type, message, options)
        @base       = base
        @attribute  = attribute
        @type       = type
        @message    = message
        @options    = options
      end

      def <=>(other)
        to_hash <=> other.to_hash
      end

      def to_hash
        {
          attribute: attribute,
          type:      type,
          message:   message,
          options:   options
        }
      end

      def as_json(*json_args)
        to_hash
      end

      def hash
        to_hash.hash
      end

      def to_s
        formatters.build(:human, self).format_message
      end

      def inspect
        to_s.inspect
      end

      def ==(other)
        return type == other if other.is_a?(Symbol)
        to_s == other.to_s
      end
    end
  end
end
