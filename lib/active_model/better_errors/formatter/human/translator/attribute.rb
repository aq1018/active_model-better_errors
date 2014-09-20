# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Formatter
      class Human
        class Translator
          #
          # Translates a model attribute.
          #
          class Attribute < self
            def translate
              Builder::Attribute.build(error_message)
            end
          end
        end
      end
    end
  end
end
