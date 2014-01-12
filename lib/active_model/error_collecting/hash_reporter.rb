# encoding: utf-8

module ActiveModel
  module ErrorCollecting
    #
    # HashReporter
    #
    class HashReporter < Reporter
      def to_hash
        fail 'abstract method'
      end
    end
  end
end
