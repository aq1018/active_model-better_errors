# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Reporter
      #
      # Hash Reporter
      #
      class Hash < self
        #
        # Returns a hash of formatted errors.
        #
        def to_hash
          collection.reduce({}) do |a, e|
            _attribute, error_message = e
            formatter = formatter_for(error_message)
            attribute = formatter.format_attribute
            message   = formatter.format_message
            options   = error_message.options
            a[attribute] ||= []
            a[attribute] << { message: message, options: options }
            a
          end
        end
      end
    end
  end
end
