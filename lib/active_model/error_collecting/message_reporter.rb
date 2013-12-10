module ActiveModel
  module ErrorCollecting
    class MessageReporter < Reporter
      def full_messages
        fail 'abstract method'
      end

      def full_message(attribute, message)
        fail 'abstract method'
      end

      def generate_message(attribute, type = :invalid, options = {})
        fail 'abstract method'
      end
    end
  end
end
