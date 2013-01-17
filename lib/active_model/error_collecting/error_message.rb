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

      def identify(message, override)
        symbol = string = nil
        symbol = message if message.is_a?(Symbol)
        symbol = override if override.is_a?(Symbol)

        string = message if message.is_a?(String)
        string = override if override.is_a?(String)

        string = nil if string.blank?

        [symbol, string]
      end

      def self.build(attribute, message, options=nil)
        raise ArgumentError, "message cannot be nil" if message.blank?

        options   = options ? options : {}
        options   = options.except(*CALLBACKS_OPTIONS)

        message   = normalize_message message
        override  = normalize_message options.delete(:message)

        symbol, string = identify message, override

        new(attribute, symbol, string, options)
      end

      attr_reader :attribute, :type, :message, :options

      def initialize(attribute, type, message, options = {})
        @attribute  = attribute
        @type       = type
        @message    = message
        @options    = options
      end

      def <=> (other)
        equal = [:attribute, :type, :message].all? do |method|
          ( send(method) <=> other.send(method) ) == 0
        end

        equal ? 0 : nil
      end

      def eql?(other)
        self.class == other.class && self <=> other
      end

      def to_hash
        {
          attribute: attribute,
          type:      type,
          message:   message,
          options:   options
        }
      end

      def hash
        to_hash.hash
      end
    end
  end
end
