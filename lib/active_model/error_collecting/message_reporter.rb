module ActiveModel
  module ErrorCollecting
    class MessageReporter < Reporter
      def full_messages
        raise "abstract method"
      end

      def full_message(attribute, message)
        raise "abstract method"
      end

      def generate_message(attribute, type = :invalid, options = {})
        raise "abstract method"
      end
    end
  end
end