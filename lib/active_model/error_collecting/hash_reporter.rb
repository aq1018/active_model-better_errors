module ActiveModel
  module ErrorCollecting
    class HashReporter < Reporter
      def to_hash
        fail 'abstract method'
      end
    end
  end
end
