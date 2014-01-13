# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Reporter
      #
      # Array Reporter
      #
      class Array < self
        #
        # Returns a hash of formatted errors.
        #
        def to_a
          collection.reduce({}) do |a, e|
            formatter_for(e).format_full_message
          end
        end
      end
    end
  end
end
