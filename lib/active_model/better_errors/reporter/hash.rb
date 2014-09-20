# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Reporter
      #
      # Converts a ErrorCollection into a hash.
      # It provides compatible interface for ActiveModel::Errors#to_hash
      # Elements of the hash depends on the formatter.
      #
      class Hash < self
        #
        # Returns a hash of formatted errors.
        #
        def to_hash
          collection.each_with_object({}) do |(attribute, error_message), hash|
            formatter = formatter_for(error_message)
            message   = formatter.format_message
            hash[attribute] ||= []
            hash[attribute] << message
          end
        end
      end
    end
  end
end
