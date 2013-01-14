require 'active_support/all'
# holds all the error information
module ActiveModel
  module ErrorCollecting
    class ErrorCollection
      include Enumerable
      def initialize(base)
        @base = base
        @collection = []
      end

      def add(attribute, error, options = {})
        @collection << ErrorMessage.new(@base, attribute, error, options)
      end

      def [](attribute)
        @collection.select { |obj| obj.attribute == attribute }
      end

      delegate :clear, :each, :empty?, to: :@collection
      alias_method :[]=, :add
      alias_method :get, :[]

      def delete(attribute)
        @collection.reject! { |error| error.attribute == attribute }
      end

      def set(attribute, error, options = {})
        delete attribute
        [*error].each { |e| @collection << ErrorMessageSet.new(@base, attribute, e, options) }
      end

      def remove()
      end

      def has_key?(attribute)
        get(attribute).any?
      end
    end
  end
end
