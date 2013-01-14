module ActiveModel
  module ErrorCollecting
    class HumanReporter
      def initialize(error_collection)
        @error_collection = error_collection
      end

      def full_messages
        @error_collection.sort_by(&:attribute).map do |error|
          "#{human_name(error.attribute)} #{error.message}"
        end
      end

      private
      def human_name(attribute)
        attribute.to_s.split("_").join(" ").capitalize
      end
    end
  end
end
