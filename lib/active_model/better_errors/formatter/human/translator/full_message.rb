# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Formatter
      class Human
        class Translator
          #
          # Translates attribute and error message.
          #
          class FullMessage < self
            I18N_KEY = 'errors.format'

            def translate
              base_error? ? message : I18n.translate(I18N_KEY, options)
            end

            private

            def base_error?
              error_message.attribute == :base
            end

            def attribute
              Attribute.translate(error_message)
            end

            def message
              Message.translate(error_message)
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
      end
    end
  end
end
