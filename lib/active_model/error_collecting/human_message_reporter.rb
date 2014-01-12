# encoding: utf-8

module ActiveModel
  module ErrorCollecting
    #
    # HumanMessageReporter
    #
    class HumanMessageReporter < MessageReporter
      def full_messages
        @collection.map do |attribute, error_message|
          message = ::ActiveModel::ErrorCollecting.format_message(
            base, error_message
          )
          full_message attribute, message
        end
      end

      def full_message(attribute, message)
        return message if attribute == :base
        str = attribute.to_s.gsub('.', '_').humanize
        str = base.class.human_attribute_name(attribute, default: str)

        I18n.t(
          'errors.format',
          default:    '%{attribute} %{message}',
          attribute:  str,
          message:    message
        )
      end

      # This method is not used internally.
      # This is for API Compatibility with ActiveModel::Errors only
      def generate_message(attribute, type = :invalid, options = {})
        error_message = ErrorMessage.build(base, attribute, type, options)
        ::ActiveModel::ErrorCollecting.format_message(base, error_message)
      end
    end
  end
end
