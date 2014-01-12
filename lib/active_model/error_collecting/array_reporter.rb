# encoding: utf-8

module ActiveModel
  module ErrorCollecting
    #
    # ArrayReporter
    #
    class ArrayReporter < Reporter
      def to_a
        fail 'abstract method'
      end
    end
  end
end
