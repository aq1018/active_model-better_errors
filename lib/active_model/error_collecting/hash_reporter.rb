module ActiveModel
  module ErrorCollecting
    class HashReporter < Reporter
      def to_hash
        raise "abstract method"
      end
    end
  end
end