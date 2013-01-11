module ActiveModel
  module ErrorCollecting
    class UnsupportedMethod < RuntimeError
      def initialize(method_name)
        "#{method_name} is not supported. Maybe you want to switch to human consumer by calling errors.set_consumer(:human)."
      end
    end

    class << self
      def set_consumer(consumer, error_klass)
        @consumer_maps ||= {}
        @consumer_maps[consumer.to_s] = error_klass
      end

      def errors_class_for(consumer)
        @consumer_maps[consumer.to_s]
      end
    end

    set_error_reporter :json, JsonReporter
    set_error_reporter :xml,  XMLReporter
    set_error_reporter :html, HTMLReporter
    set_error_reporter :legacy, ::ActiveModel::Errors
  end
end