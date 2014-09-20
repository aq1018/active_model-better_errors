# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # Provides compatible interface to fully replace for ActiveModel::Errors.
    #
    class Errors
      include Enumerable
      include Helper, Emulation, Concord.new(:base)
      public :base

      def formatter_type
        @formatter_type ||= default_formatter_type
      end

      def format(type)
        @formatter_type = type
        self
      end

      private

      def error_collection
        @error_collection ||= ErrorCollection.new(base)
      end

      def reporter_for(type)
        reporters.build(type, error_collection, formatter_type)
      end

      #
      # Build #message_reporter, #hash_reporter,
      # #array_reporter methods that are used by Emulaltion module.
      reporter_types.each do |type|
        define_method(:"#{type}_reporter") { reporter_for(type) }
      end
    end
  end
end
