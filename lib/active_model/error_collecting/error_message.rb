module ActiveModel
  module ErrorCollecting
    class ErrorMessage
      attr_reader :key, :message
      def initialize(message)
        case message
        when Array
          @key, @message = message
        when Symbol
          @key = message
        else
          ActiveSupport::Deprecation.warn("Using strings with errors#add is not supported by BetterErrors, use [:invalid, 'this is invalid'] instead.")
          @message = message.to_s
        end
      end

      def human?
        message.present?
      end

      def robot?
        key.present?
      end

      def to_s
        message
      end
    end
  end
end
