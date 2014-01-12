# encoding: utf-8

module ActiveModel
  module ErrorCollecting
    #
    # HumanHashReporter
    #
    class HumanHashReporter < HashReporter
      def to_hash
        collection.to_hash.reduce({}) do |hash, kv|
          attribute, error_message_set = kv
          hash[attribute] = error_message_set.map do |error_message|
            HumanMessageFormatter.new(base, error_message).format_message
          end
          hash
        end
      end
    end
  end
end
