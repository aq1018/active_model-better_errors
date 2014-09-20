# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Reporter
      #
      # Message Reporter
      #
      class Message < self
        def full_messages
          collection.map do |_attribute, error_message|
            formatter_for(error_message).format_full_message
          end
        end

        def full_message(attribute, message)
          message = ErrorMessage::Builder.build(base, attribute, message)
          formatter_for(message).format_full_message
        end

        def full_messages_for(attribute)
          collection[attribute].map do |error_message|
            formatter_for(error_message).format_full_message
          end
        end

        # This method is not used internally.
        # This is for API Compatibility with ActiveModel::Errors only
        def generate_message(attribute, type = nil, options = nil)
          error_message = ErrorMessage::Builder.build(
            base, attribute, type, options
          )
          formatter_for(error_message).format_message
        end
      end
    end
  end
end
