# coding: utf-8

module ActiveModel
  module BetterErrors
    class Formatter
      #
      # Machine Formatter
      #
      class Machine < self
        #
        # Format attribute from `attribute`.
        #
        # @return [Symbol] the formatted attribute.
        #
        def format_attribute
          attribute
        end

        #
        # Format message from `type`.
        #
        # @return [Symbol] the formatted attribute.
        #
        def format_message
          type
        end

        #
        # Format full message from `attribute`, `type` and `options`.
        #
        # @return [Hash] the formatted error hash.
        #
        def format_full_message
          {
            attribute:  format_attribute,
            message:    format_message,
            options:    options
          }
        end
      end
    end
  end
end
