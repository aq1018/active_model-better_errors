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
        def to_hash(full_message = nil)
          collection.each_with_object({}) do |(attribute, error_message), a|
            formatter = formatter_for(error_message)
            method = full_message ? :format_full_message : :format_message
            message   = formatter.send method
            a[attribute] ||= []
            a[attribute] << message
          end
        end
      end
    end
  end
end
