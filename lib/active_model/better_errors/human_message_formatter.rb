# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # HumanMessageFormatter
    #
    class HumanMessageFormatter < Formatter
      def format_message
        return message if message

        keys = i18n_keys
        key  = keys.shift

        options = {
          default: keys,
          model: base.class.model_name.human,
          attribute: base.class.human_attribute_name(attribute),
          value: value
        }.merge(self.options)

        I18n.translate key, options
      end

      private

      def type
        error_message.type || :invalid
      end

      def value
        return if attribute == :base
        base.send :read_attribute_for_validation, attribute
      end

      def ancestor_keys
        return [] unless base.class.respond_to?(:i18n_scope)
        scope = base.class.i18n_scope

        base.class.lookup_ancestors.map do |klass|
          key_base = "#{scope}.errors.models.#{klass.model_name.i18n_key}"
          [
            :"#{key_base}.attributes.#{attribute}.#{type}",
            :"#{key_base}.#{type}"
          ]
        end
      end

      def i18n_keys
        keys = ancestor_keys
        keys << message

        if base.class.respond_to?(:i18n_scope)
          keys << :"#{base.class.i18n_scope}.errors.messages.#{type}"
        end

        keys << :"errors.attributes.#{attribute}.#{type}"
        keys << :"errors.messages.#{type}"

        keys.compact!
        keys.flatten!
        keys
      end
    end
  end
end
