# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # MachineArrayReporter
    #
    class MachineArrayReporter < ArrayReporter
      def to_a
        collection.to_a.map do |error_message|
          format_error_message error_message
        end
      end

      def format_error_message(error_message)
        result = {}
        result[:attribute] = error_message.attribute.to_s
        result[:type] = error_message.type || :invalid

        options = error_message.options
        result[:options] = options unless options.blank?

        result
      end
    end
  end
end
