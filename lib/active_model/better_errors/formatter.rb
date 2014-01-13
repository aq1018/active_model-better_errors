# coding: utf-8

module ActiveModel
  module BetterErrors
    #
    # Abstract Formatter class
    class Formatter
      include AbstractType, Concord.new(:error_message)

      delegate :base, :attribute, :type, :message, :options, to: :error_message

      #
      # Format attribute from `attribute`.
      #
      # @return [String, Symbol] the formatted attribute.
      #
      abstract_method :format_attribute

      #
      # Format message from `type` or `message`.
      #
      # @return [String, Symbol] the formatted attribute.
      #
      abstract_method :format_message

      #
      # Format full message from `attribute`, `type` and `message`.
      #
      # @return [String, Hash] the formatted attribute.
      #
      abstract_method :format_full_message
    end
  end
end
