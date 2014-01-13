# coding: utf-8

module ActiveModel
  module BetterErrors
    #
    # Helper class to handle registration of classes
    class Registry
      attr_reader :map

      def initialize(map = {})
        @map = map
      end

      def [](type)
        map[type]
      end

      def register(type, klass)
        map[type] = klass
        self
      end

      def types
        map.keys
      end

      def build(type, *args)
        self[type].new(*args)
      end
    end
  end
end
