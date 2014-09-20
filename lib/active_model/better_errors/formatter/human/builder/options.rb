# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Formatter
      class Human
        class Builder
          #
          # Builds I18n translation options.
          #
          class Options < self
            include Concord.new(:error_message, :keys)

            def build
              opt = {}
              opt[:default] = keys
              opt[:model] = model
              opt[:attribute] = attribute
              opt[:value] = value
              opt.merge!(error_message.options)
              opt
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
        end
      end
    end
  end
end
