module ActiveModel
  module ErrorCollecting
    class ErrorMessageSet
      include Enumerable
      delegate :each, :length, to: :@set
      def initialize(array)
        @set = array.map { |element| ErrorMessage.new(element) }.to_set
      end

      def <<(element)
        @set << ErrorMessage.new(element)
      end

      def to_a
        @set.to_a
      end
    end
  end
end
