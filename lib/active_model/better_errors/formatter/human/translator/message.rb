module ActiveModel
  module BetterErrors
    class Formatter
      class Human
        class Translator
          class Message < self
            attr_reader :key, :keys

            def initialize(error_message)
              super
              keys  = Builder::Keys.build(error_message)
              @key  = keys.shift
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
        end
      end
    end
  end
end
