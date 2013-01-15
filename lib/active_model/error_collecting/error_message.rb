module ActiveModel
  module ErrorCollecting
    class ErrorMessage
      include Comparable

      def self.build(attribute, message, options=nil)
        raise ArgumentError, "message cannot be nil" if message.blank?
        symbol    = nil
        string    = nil
        options   = options ? options.clone : {}
        override  = options.delete(:message)

        symbol = message if Symbol === message
        symbol = override if Symbol === override

        string = message.to_s  if message && !(Symbol === message)
        string = override.to_s if override && !(Symbol === override)

        string = nil if string.blank?

        new(attribute, symbol, string, options)
      end

      attr_reader :attribute, :key, :message, :options

      def initialize(attribute, key, message, options = {})
        @attribute = attribute
        @key = key
        @message = message
        @options = options
      end

      def <=> (other)
        equal = [:attribute, :key, :message].all? do |method|
          ( send(method) <=> other.send(method) ) == 0
        end

        equal ? 0 : nil
      end

      def eql?(other)
        self.class == other.class && self <=> other
      end

      def hash
        # hack :(
        "attribute=#{attribute}&key=#{key}&message=#{message}".hash
      end
    end
  end
end
