module ActiveModel
  module ErrorCollecting
    class HumanArrayReporter
      attr_reader :collection
      def initialize(collection)
        @collection = collection
      end

      def base
        @collection.base
      end

      def to_a
        HumanMessageReporter.new(collection).full_messages
      end
    end
  end
end
