module ActiveModel
  module ErrorCollecting
    class MachineArrayReporter < ArrayReporter
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
