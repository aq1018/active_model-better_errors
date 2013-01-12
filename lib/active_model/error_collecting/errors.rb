module ActiveModel
  module ErrorCollecting
    class Errors
      MODEL_METHODS = [
        :clear, :has_key?, :get, :set, :delete, :[], :[]=,
        :each, :size, :values, :keys, :count, :empty?,
        :added?, :add, :add_on_empty, :add_on_blank
      ]

      HUMAN_REPORTER_METHODS = [
        :full_messages, :full_message, :generate_messages
      ]

      delegate *MODEL_METHODS,  to: :error_collection
      delegate *HUMAN_REPORTER_METHODS,  to: :human_reporter
      delegate :to_hash, to: :hash_reporter
      delegate :to_a, to: :array_reporter

      alias_method :blank?, :empty?

      attr_accessor :error_collection, :human_reporter, :hash_reporter, :array_reporter

      def initialize(base, options={})
        @base = base
        @error_collection = ErrorCollection.new
        create_reporters options[:reporters]
      end

      def create_reporters(reporters)
        @human_reporter = reporters[:human].new(error_collection)
        @hash_reporter = reporters[:hash].new(error_collection)
        @array_reporter = reporters[:array].new(error_collection)
      end

      def to_xml(options={})
        to_a.to_xml options.reverse_merge(:root => "errors", :skip_types => true)
      end

      def as_json(options=nil)
        to_hash
      end
    end
  end
end