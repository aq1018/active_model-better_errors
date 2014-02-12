module ActiveModel
  module BetterErrors
    class Formatter
      class Human
        class Builder
          class Attribute < self
            def build
              error_message.base.class.human_attribute_name(
                error_message.attribute,
                default: error_message.attribute.to_s.gsub('.', '_').humanize
              )
            end
          end
        end
      end
    end
  end
end
