# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # ErrorMessage
    #
    class ErrorMessage
      include Helper, Comparable, Concord.new(:base, :attribute, :error)

      delegate :hash, to: :to_hash
      delegate :inspect, to: :to_s

      public :base, :attribute

      def type
        error[:type]
      end

      def message
        error[:message]
      end

      def options
        error[:options] || {}
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

      def to_s
        formatters.build(:human, self).format_message
      end

      def ==(other)
        return type == other if other.is_a?(Symbol)
        to_s == other.to_s
      end
    end
  end
end
