module ActiveModel
  module ErrorCollecting
    class HumanMessageFormatter
      extend Forwardable

      def_delegators :@error_message, :attribute, :message, :options

      attr_reader :base, :error_message

      def initialize(base, error_message)
        @base, @error_message = base, error_message
      end

      def type
        @error_message.type || :invalid
      end

      def format_message
        return message if message && error_message.type.nil?

        keys = i18n_keys
        key  = keys.shift

        value = (attribute != :base ? base.send(:read_attribute_for_validation, attribute) : nil)

        options = {
          :default => keys,
          :model => base.class.model_name.human,
          :attribute => base.class.human_attribute_name(attribute),
          :value => value
        }.merge(self.options)

        I18n.translate key, options
      end

      private

      def i18n_keys
        if base.class.respond_to?(:i18n_scope)
          keys = base.class.lookup_ancestors.map do |klass|
            [ :"#{base.class.i18n_scope}.errors.models.#{klass.model_name.i18n_key}.attributes.#{attribute}.#{type}",
              :"#{base.class.i18n_scope}.errors.models.#{klass.model_name.i18n_key}.#{type}" ]
          end
        else
          keys = []
        end
        keys << message
        keys << :"#{base.class.i18n_scope}.errors.messages.#{type}" if base.class.respond_to?(:i18n_scope)
        keys << :"errors.attributes.#{attribute}.#{type}"
        keys << :"errors.messages.#{type}"

        keys.compact!
        keys.flatten!
        keys
      end
    end
  end
end