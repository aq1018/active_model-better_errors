module ActiveModel
  module ErrorCollecting
    class HumanMessageReporter < MessageReporter
      def full_messages
        @collection.map do |attribute, error_message|
          formatter = HumanMessageFormatter.new(base, error_message)
          message   = formatter.format_message
          full_message attribute, message
        end
      end

      def full_message(attribute, message)
        return message if attribute == :base
        attr_name = attribute.to_s.gsub('.', '_').humanize
        attr_name = base.class.human_attribute_name(attribute, default: attr_name)
        I18n.t(:"errors.format", {
          default: '%{attribute} %{message}',
          attribute: attr_name,
          message: message
        })
      end

      # This method is not used internally.
      # This is for API Compatibility with ActiveModel::Errors only
      def generate_message(attribute, type = :invalid, options = {})
        error_message = ErrorMessage.build(base, attribute, type, options)
        formatter     = HumanMessageFormatter.new(base, error_message)
        formatter.format_message
      end
    end
  end
end
