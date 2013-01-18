module ActiveModel
  module ErrorCollecting
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
        result[:options] = error_message.options unless error_message.options.blank?
        result
      end
    end
  end
end
