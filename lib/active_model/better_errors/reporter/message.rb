# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Reporter
      #
      # Message Reporter
      #
      class Message < self
        def full_messages
          collection.map do |attribute, error_message|
            full_message attribute, error_message
          end
        end

        def full_message(attribute, message)
          error_message =
            if message.is_a?(ErrorMessage)
              message
            else
              ErrorMessage::Builder.build(base, attribute, nil, message)
            end

          formatter_for(error_message).format_full_message
        end

        def full_messages_for(attribute)
          collection[attribute].each do |error_message|
            formatter_for(error_message).format_full_message
          end
        end

        # This method is not used internally.
        # This is for API Compatibility with ActiveModel::Errors only
        def generate_message(attribute, type = :invalid, options = {})
          error_message = ErrorMessage::Builder.build(
            base, attribute, type, nil, options
          )
          formatter_for(error_message).format_message
        end
      end
    end
  end
end
