module ActiveModel
  module ErrorCollecting
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
        ( v = @collection[attribute] ) && v.any?
      end

      def get(attribute)
        @collection[attribute]
      end

      def set(attribute, errors)
        return delete attribute if errors.nil?
        @collection[attribute] = ErrorMessageSet.new(attribute, errors)
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
          self[attribute].each { |error_message| yield attribute, error_message }
        end
      end

      def size
        values.inject(0){ |sum, set| sum += set.size }
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
        self[attribute].add(message, options)
        @collection[attribute].add(message, options)
      end

      def added?(attribute, message = nil, options = {})
        self[attribute].include? ErrorMessage.build(attribute, message, options)
      end
    end
  end
end
