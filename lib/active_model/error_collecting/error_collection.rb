require 'active_support/all'
# holds all the error information
module ActiveModel
  module ErrorCollecting
    class ErrorCollection
      def initialize
        @collection = Hash.new { |h, k| h[k] = ErrorMessageSet.new([]) }
      end

      def add(attribute, error)
        @collection[attribute] << error
      end

      delegate :[], :clear, :delete, :empty?, to: :@collection
      alias_method :[]=, :add
      alias_method :get, :[]

      def set(attribute, error)
        @collection[attribute] = ErrorMessageSet.new([*error])
      end

      def remove()
      end

      def has_key?(attribute)
        get(attribute).any?
      end
    end
  end
end
