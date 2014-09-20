# encoding: utf-8

module ActiveModel
  module BetterErrors
    class ErrorMessage
      #
      # Utility class containing the business logic needed
      # to build an ErrorMessage object.
      #
      class Builder
        include Adamantium::Flat

        CALLBACKS_OPTIONS = [
          :if, :unless, :on, :allow_nil, :allow_blank, :strict
        ]

        class << self
          def normalize(message)
            case message
            when nil
              nil
            when Symbol
              message
            when Proc
              message.call
            else
              message.to_s
            end
          end

          def build(base, attribute, message, options = nil)
            options ||= {}
            options = options.except(*CALLBACKS_OPTIONS)
            new(base, attribute, message, options).build
          end
        end

        attr_reader :base, :attribute, :message, :options

        def initialize(base, attribute, message, options)
          @base       = base
          @attribute  = attribute
          @message    = message
          @options    = options
        end

        def override
          options.delete(:message)
        end
        memoize :override

        def normalized_message
          self.class.normalize(message)
        end
        memoize :normalized_message

        def normalized_override
          self.class.normalize(override)
        end
        memoize :normalized_override

        def message_symbol
          if normalized_override.instance_of?(Symbol)
            normalized_override
          elsif normalized_message.instance_of?(Symbol)
            normalized_message
          end
        end

        def message_string
          str = if normalized_override.instance_of?(String)
                  normalized_override
                elsif normalized_message.instance_of?(String)
                  normalized_message
                end

          str unless str.blank?
        end

        def build
          ErrorMessage.new(
            base, attribute,
            type: message_symbol,
            message: message_string,
            options: options
          )
        end
      end
    end
  end
end
