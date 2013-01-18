module ActiveModel
  module ErrorCollecting
    class ArrayReporter < Reporter
      def to_a
        raise "abstract method"
      end
    end
  end
end