module ActiveModel
  module ErrorCollecting
    class HashReporter
      def initialize(error_collection)
        @error_collection = error_collection
      end

      def to_hash
        @error_collection.group_by(&:attribute).each_with_object({}) do |attribute_errors, hash|
          attribute, errors = attribute_errors
          hash[attribute] = errors.map(&:key)
        end
      end
    end
  end
end
