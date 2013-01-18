module ActiveModel
  module ErrorCollecting
    class Reporter
      attr_reader :collection
      def initialize(collection)
        @collection = collection
      end

      def base
        @collection.base
      end
    end
  end
end