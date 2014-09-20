# encoding: utf-8

module ActiveModel
  # :nodoc:
  module BetterErrors
    class Reporter
      #
      # Provides interface for ActiveModel::Errors#full_messages,
      # #full_message, #full_message_for, and #generate_message
      #
      class Message < Array
        alias_method :full_messages, :to_a

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

    reporters.register(:message, Reporter::Message)
  end
end
