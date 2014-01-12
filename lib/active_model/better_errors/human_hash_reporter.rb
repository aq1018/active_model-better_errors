# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # HumanHashReporter
    #
    class HumanHashReporter < HashReporter
      def to_hash
        collection.to_hash.reduce({}) do |hash, kv|
          attribute, error_message_set = kv
          hash[attribute] = error_message_set.map do |error_message|
            ::ActiveModel::BetterErrors.format_message(base, error_message)
          end
          hash
        end
      end
    end
  end
end
