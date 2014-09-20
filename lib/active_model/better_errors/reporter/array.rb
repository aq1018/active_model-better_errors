# encoding: utf-8

module ActiveModel
  # :nodoc:
  module BetterErrors
    class Reporter
      #
      # Converts a ErrorCollection into an array.
      # It provides compatible interface for ActiveModel::Errors#to_a
      # Elements of the array depends on the formatter.
      #
      class Array < self
        #
        # Returns an array of formatted errors.
        #
        def to_a
          collection.map do |_attribute, error_message|
            formatter_for(error_message).format_full_message
          end
        end
      end
    end

    reporters.register(:array, Reporter::Array)
  end
end
