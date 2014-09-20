# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Formatter
      class Human
        class Builder
          # :nodoc:
          class Keys < self
            def build
              keys      = ancestor_keys
              attribute = error_message.attribute

              keys << error_message.message
              keys << :"#{i18n_scope}.errors.messages.#{type}" if i18n_scope?
              keys << :"errors.attributes.#{attribute}.#{type}"
              keys << :"errors.messages.#{type}"

              keys.compact.flatten
            end

            private

            def type
              error_message.type || :invalid
            end

            def i18n_scope
              error_message.base.class.i18n_scope
            end

            def i18n_scope?
              error_message.base.class.respond_to?(:i18n_scope)
            end

            def key_base(klass)
              "#{i18n_scope}.errors.models.#{klass.model_name.i18n_key}"
            end

            def ancestor_keys
              return [] unless i18n_scope?

              attribute = error_message.attribute
              base      = error_message.base

              base.class.lookup_ancestors.map do |klass|
                prefix = key_base(klass)

                [
                  :"#{prefix}.attributes.#{attribute}.#{type}",
                  :"#{prefix}.#{type}"
                ]
              end
            end
          end
        end
      end
    end
  end
end
