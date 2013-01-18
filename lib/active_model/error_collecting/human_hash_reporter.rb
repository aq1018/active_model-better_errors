module ActiveModel
  module ErrorCollecting
    class HumanHashReporter

      attr_reader :collection
      def initialize(collection)
        @collection = collection
      end

      def base
        collection.base
      end

      def to_hash
        collection.to_hash.inject({}) do |hash, kv|
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
