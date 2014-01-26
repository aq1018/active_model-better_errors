# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Reporter
      #
      # Array Reporter
      #
      class Array < self
        #
        # Returns an array of formatted errors.
        #
        def to_a
          collection.map do |_, error_message|
            formatter_for(error_message).format_full_message
          end
        end
      end
    end
  end
end
