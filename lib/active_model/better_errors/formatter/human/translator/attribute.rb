module ActiveModel
  module BetterErrors
    class Formatter
      class Human
        class Translator
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
