# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Formatter
      class Human
        class Builder
          #
          # Builds translated attribute.
          #
          class Attribute < self
            def build
              attribute = error_message.attribute
              default = attribute.to_s.gsub('.', '_').humanize
              klass = error_message.base.class
              klass.human_attribute_name(attribute, default: default)
            end
          end
        end
      end
    end
  end
end
