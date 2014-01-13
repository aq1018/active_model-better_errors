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
            formatter = formatter_for(e)
            attribute = formatter.format_attribute
            message   = formatter.format_message
            a[attribute] ||= []
            a[attribute] << message
          end
        end
      end
    end
  end
end
