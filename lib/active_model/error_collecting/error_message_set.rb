module ActiveModel
  module ErrorCollecting
    class ErrorMessageSet
      include Enumerable
      extend  Forwardable

      def_delegators :@set, :each, :length, :size, :clear, :first, :last, :[]

      def initialize(base, attribute, errors=[])
        @base      = base
        @attribute = attribute
        @set        = []
        errors.each { |error| add(*error) }
      end

      def add(message, options=nil)
        error_message = ErrorMessage.build(@base, @attribute, message, options)
        @set << error_message
        error_message
      end

      def []=(index, error)
        @set[index] = ErrorMessage.build(@base, @attribute, *error)
      end

      def <<(error)
        add(*error)
      end

      def to_a
        @set.dup
      end

      def empty?
        @set.length == 0
      end
      alias_method :blank?, :empty?

    end
  end
end
