# coding: utf-8

module ActiveModel
  module BetterErrors
    class Formatter
      #
      # Uses `i18n` to translate error messages into human readable format.
      #
      class Human < self
        #
        # Format attribute from `attribute`.
        #
        # @return [String] the formatted attribute.
        #
        def format_attribute
          Translator::Attribute.translate(error_message)
        end

        #
        # Format message from `type`.
        #
        # @return [String] the formatted error message.
        #
        def format_message
          Translator::Message.translate(error_message)
        end

        #
        # Format full message from `attribute`, `type` and `options`.
        #
        # @return [String] the formatted error message with attribute.
        #
        def format_full_message
          Translator::FullMessage.translate(error_message)
        end
      end
    end
  end
end
