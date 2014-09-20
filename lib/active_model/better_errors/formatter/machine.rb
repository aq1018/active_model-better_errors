# coding: utf-8

module ActiveModel
  # :nodoc:
  module BetterErrors
    class Formatter
      #
      # Formates messages into machine readable format.
      #
      class Machine < self
        #
        # Format attribute from `attribute`.
        #
        # @return [Symbol] the formatted attribute.
        #
        alias_method :format_attribute, :attribute

        #
        # Format message from `type`.
        #
        # @return [Symbol] the formatted attribute.
        #
        def format_message
          {
            message: (type || :invalid),
            options: options
          }
        end

        #
        # Format full message from `attribute`, `type` and `options`.
        #
        # @return [Hash] the formatted error hash.
        #
        def format_full_message
          {
            attribute:  format_attribute,
            message:    (type || :invalid),
            options:    options
          }
        end
      end
    end

    formatters.register(:machine, Formatter::Machine)
  end
end
