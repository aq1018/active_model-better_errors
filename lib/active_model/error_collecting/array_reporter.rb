module ActiveModel
  module ErrorCollecting
    class HashReporter < Reporter
      def to_a
        raise "abstract method"
      end
    end
  end
end