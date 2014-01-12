# encoding: utf-8

module ActiveModel
  module ErrorCollecting
    #
    # Reporter
    #
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
