module ActiveModel
  module BetterErrors
    class Formatter
      class Human
        class Translator
          class FullMessage < self
            def translate
              base_error? ? message : I18n.translate(key, options)
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
      end
    end
  end
end
