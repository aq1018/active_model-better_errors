# coding: utf-8

module ActiveModel
  module BetterErrors
    class Formatter
      #
      # Human Formatter
      # Uses `i18n` to translate error into human readable format.
      #
      class Human < self
        # :nodoc:
        class Builder
          include AbstractType, Concord.new(:error_message)

          def self.build(*args)
            new(*args).build
          end

          def base_error?
            error_message.attribute == :base
          end

          abstract_method :build

          # :nodoc:
          class Value < self
            def build
              return if base_error?
              read_attribute_value
            end

            private

            def read_attribute_value
              error_message.base.send(
                :read_attribute_for_validation,
                error_message.attribute
              )
            end
          end

          # :nodoc:
          class Attribute < self
            def build
              error_message.base.class.human_attribute_name(
                error_message.attribute,
                default: error_message.attribute.to_s.gsub('.', '_').humanize
              )
            end
          end

          # :nodoc:
          class Options < self
            include Concord.new(:error_message, :keys)

            def build
              {
                default:    keys,
                model:      model,
                attribute:  attribute,
                value:      value
              }.merge(error_message.options)
            end

            private

            def model
              error_message.base.class.model_name.human
            end

            def attribute
              Builder::Attribute.build(error_message)
            end

            def value
              Builder::Value.build(error_message)
            end
          end

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
                [
                  :"#{key_base(klass)}.attributes.#{attribute}.#{type}",
                  :"#{key_base(klass)}.#{type}"
                ]
              end
            end
          end
        end

         # :nodoc:
        class Translator
          include AbstractType, Concord.new(:error_message)
          include

          def self.translate(error_message)
            new(error_message).translate
          end

          abstract_method :translate

          # :nodoc:
          class Attribute < self
            def translate
              Builder::Attribute.build(error_message)
            end
          end

          # :nodoc:
          class Message < self
            attr_reader :key, :keys

            def initialize(error_message)
              super
              keys = Builder::Keys.build(error_message)
              @key = keys.shift
              @keys = keys
            end

            def translate
              I18n.translate(key, options)
            end

            private

            def options
              Builder::Options.build(error_message, keys)
            end
          end

          # :nodoc:
          class FullMessage < self
            def translate
              base_error? ? message : I18n.translate(key, options)
            end

            private

            def base_error?
              error_message.attribute == :base
            end

            def attribute
              Translator::Attribute.translate(error_message)
            end

            def message
              Translator::Message.translate(error_message)
            end

            def key
              'errors.format'
            end

            def options
              {
                default:    '%{attribute} %{message}',
                attribute:  attribute,
                message:    message
              }
            end
          end
        end

        #
        # Format attribute from `attribute`.
        #
        # @return [String] the formatted attribute.
        #
        def format_attribute
          Translator::Attribute.translate(error_message)
        end

        #
        # Format message from `type`.
        #
        # @return [String] the formatted error message.
        #
        def format_message
          Translator::Message.translate(error_message)
        end

        #
        # Format full message from `attribute`, `type` and `options`.
        #
        # @return [String] the formatted error message with attribute.
        #
        def format_full_message
          Translator::FullMessage.translate(error_message)
        end
      end
    end
  end
end
