# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # Errors
    #
    class Errors
      include Emulation

      attr_reader :base
      def initialize(base)
        @base = base
        @reporters = {}
        @reporter_classes = reporter_classes
      end

      def error_collection
        @error_collection ||= ErrorCollection.new(@base)
      end

      def message_reporter
        get_reporter(:message)
      end

      def hash_reporter
        get_reporter(:hash)
      end

      def array_reporter
        get_reporter(:array)
      end

      def set_reporter(type, reporter)
        type = type.to_s
        klass = ::ActiveModel::BetterErrors
          .get_reporter_class(type, reporter)

        @reporter_classes[type] = klass
        @reporters.delete type
      end

      def get_reporter(type)
        type = type.to_s
        klass = get_reporter_class(type)
        @reporters[type] = klass.new(error_collection)
      end

      def reporter_classes
        ::ActiveModel::BetterErrors.reporters
      end

      def get_reporter_class(type)
        type = type.to_s
        @reporter_classes[type]
      end
    end
  end
end
