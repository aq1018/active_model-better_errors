# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Formatter
      class Human
        class Builder
          #
          # Retreive ActiveModel attribute value.
          #
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
        end
      end
    end
  end
end
