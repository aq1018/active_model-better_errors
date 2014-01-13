# coding: utf-8

module ActiveModel
  module BetterErrors
    class Formatter
      #
      # Human Formatter
      # Uses `i18n` to translate error into human readable format.
      #
      class Human < self
        #
        # Format attribute from `attribute`.
        #
        # @return [String] the formatted attribute.
        #
        def format_attribute
          str = attribute.to_s.gsub('.', '_').humanize
          base.class.human_attribute_name(attribute, default: str)
        end

        #
        # Format message from `type`.
        #
        # @return [String] the formatted error message.
        #
        def format_message
          return message if message && type.nil?

          keys = i18n_keys
          key  = keys.shift

          options = {
            default:    keys,
            model:      base.class.model_name.human,
            attribute:  format_attribute,
            value:      value
          }.merge(self.options)

          I18n.translate(key, options)
        end

        #
        # Format full message from `attribute`, `type` and `options`.
        #
        # @return [String] the formatted error message with attribute.
        #
        def format_full_message
          return format_message if attribute == :base

          attribute = format_attribute
          message   = format_message

          options = {
            default:    '%{attribute} %{message}',
            attribute:  attribute,
            message:    message
          }

          I18n.translate('errors.format', options)
        end

        private

        def type
          super || :invalid
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
end
