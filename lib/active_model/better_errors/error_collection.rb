# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # ErrorCollection
    #
    class ErrorCollection
      include Enumerable, Concord.new(:base)

      delegate :clear, :values, :keys, :delete, to: :collection

      def include?(attribute)
        (v = get(attribute)) && v.any?
      end

      def get(attribute)
        collection[attribute]
      end

      def set(attribute, errors)
        return delete(attribute) if errors.nil?
        collection[attribute] = ErrorMessageSet.new(base, attribute, errors)
      end

      def [](attribute)
        get(attribute.to_sym) || set(attribute.to_sym, [])
      end

      def []=(attribute, error)
        self[attribute] << error
      end

      def each
        collection.each_key do |attribute|
          self[attribute].each do |error_message|
            yield attribute, error_message
          end
        end
      end

      def size
        values.reduce(0) { |a, e| a + e.size }
      end
      alias_method :count, :size

      def to_a
        array = []
        collection.each_key do |attribute|
          self[attribute].each { |error_message| array << error_message }
        end

        array
      end

      def to_hash
        collection.dup
      end

      def empty?
        size == 0
      end

      def add(attribute, message, options = nil)
        error = ErrorMessage::Builder.build(base, attribute, message, options)
        self[attribute] << error
        error
      end

      def added?(attribute, message = nil, options = nil)
        message = ErrorMessage::Builder.build(
          base, attribute, message, options
        )

        self[attribute].include? message
      end

      private

      def collection
        @collection ||= {}
      end
    end
  end
end
