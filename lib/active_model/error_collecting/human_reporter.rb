module ActiveModel
  module ErrorCollecting
    class HumanReporter
      def initialize(error_collection)
        @error_collection = error_collection
      end

      def full_messages
        @error_collection.each_with_object([]) do |attribute_errors, array|
          attribute, errors = attribute_errors
          errors.each do |error|
            array << "#{human_name(attribute)} #{error.message}"
          end
        end
      end

      private
      def human_name(attribute)
        attribute.to_s.split("_").join(" ").capitalize
      end
    end
  end
end
