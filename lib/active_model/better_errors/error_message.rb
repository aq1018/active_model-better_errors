# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # ErrorMessage
    #
    class ErrorMessage
      include Helper, Comparable
      include Adamantium::Flat
      include Concord.new(:base, :attribute, :error)
      public :base, :attribute

      delegate :hash, to: :to_hash
      delegate :inspect, to: :to_s

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

      def as_json(*_json_args)
        to_hash
      end

      def to_s
        formatters.build(:human, self).format_message
      end

      def ==(other)
        return type == other if other.instance_of?(Symbol)
        to_s == other.to_s
      end
    end
  end
end
