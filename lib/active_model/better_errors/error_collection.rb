# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # ErrorCollection
    #
    class ErrorCollection
      include Enumerable

      attr_reader :base
      def initialize(base)
        @base = base
        @collection = {}
      end

      def clear
        @collection.clear
      end

      def include?(attribute)
        ( v = @collection[attribute]) && v.any?
      end

      def get(attribute)
        @collection[attribute]
      end

      def set(attribute, errors)
        return delete attribute if errors.nil?
        @collection[attribute] = ErrorMessageSet.new(base, attribute, errors)
      end

      def delete(attribute)
        @collection.delete attribute
      end

      def [](attribute)
        get(attribute.to_sym) || set(attribute.to_sym, [])
      end

      def []=(attribute, error)
        self[attribute] << error
      end

      def each
        @collection.each_key do |attribute|
          self[attribute].each do |error_message|
            yield attribute, error_message
          end
        end
      end

      def size
        values.reduce(0) { |a, e| a + e.size }
      end
      alias_method :count, :size

      def values
        @collection.values
      end

      def keys
        @collection.keys
      end

      def to_a
        array = []
        @collection.each_key do |attribute|
          self[attribute].each { |error_message| array << error_message }
        end

        array
      end

      def to_hash
        @collection.dup
      end

      def empty?
        size == 0
      end

      def add(attribute, message, options = {})
        self[attribute] << [message, options]
      end

      def added?(attribute, message = nil, options = {})
        message = ErrorMessage.build(base, attribute, message, options)
        self[attribute].include? message
      end
    end
  end
end
