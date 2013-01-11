module ActiveModel
  module BetterErrors
    class APIErrors
      include Enumerable
      attr_reader :messages

      def initialize(base)
        @base     = base
        @messages = Hash.new{ |h, k| h[k] = [] }
      end

 end
  end
end