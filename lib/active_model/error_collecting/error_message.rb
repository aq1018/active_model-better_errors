module ActiveModel
  module ErrorCollecting
    class ErrorMessage
      include Comparable
      CALLBACKS_OPTIONS = [:if, :unless, :on, :allow_nil, :allow_blank, :strict]

      # return the message either as nil, symbol, or string
      def self.normalize(message)
        case message
        when nil
          nil
        when Symbol
          message
        when Proc
          message.call
        else
          message.to_s
        end
      end

      def self.identify(message, override)
        symbol = string = nil

        message   = normalize message
        override  = normalize override

        symbol = message if message.is_a?(Symbol)
        symbol = override if override.is_a?(Symbol)

        string = message if message.is_a?(String)
        string = override if override.is_a?(String)

        string = nil if string.blank?

        [symbol, string]
      end

      def self.build(base, attribute, message, options=nil)
        options   = options ? options : {}
        options   = options.except(*CALLBACKS_OPTIONS)

        symbol, string = identify message, options.delete(:message)

        new(base, attribute, symbol, string, options)
      end

      attr_reader :base, :attribute, :type, :message, :options

      def initialize(base, attribute, type, message, options = {})
        @base       = base
        @attribute  = attribute
        @type       = type
        @message    = message
        @options    = options
      end

      def <=> (other)
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
        HumanMessageFormatter.new(base, self).format_message
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
