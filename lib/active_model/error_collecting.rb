module ActiveModel
  module ErrorCollecting
    class << self
      def set_error_reporter(consumer, error_klass)
        @consumer_maps ||= {}
        @consumer_maps[consumer.to_s] = error_klass
      end

      def reporters
        @reporter_maps.clone
      end
    end
  end
end
