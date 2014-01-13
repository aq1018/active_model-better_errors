# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # Helper
    #
    module Helper
      def formatters
        ::ActiveModel::BetterErrors.formatters
      end
      module_function :formatters

      def reporters
        ::ActiveModel::BetterErrors.reporters
      end
      module_function :reporters

      def default_formatter_type
        ::ActiveModel::BetterErrors.default_formatter_type
      end
      module_function :default_formatter_type

      def default_formatter_class
        formatters[default_formatter_type]
      end

      def reporter_types
        ::ActiveModel::BetterErrors::REPORTER_TYPES
      end
      module_function :reporter_types
    end
  end
end
