# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # HumanArrayReporter
    #
    class HumanArrayReporter < ArrayReporter
      def to_a
        HumanMessageReporter.new(collection).full_messages
      end
    end
  end
end
