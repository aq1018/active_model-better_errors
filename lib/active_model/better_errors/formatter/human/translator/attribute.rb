# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Formatter
      class Human
        class Translator
          # :nodoc:
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
