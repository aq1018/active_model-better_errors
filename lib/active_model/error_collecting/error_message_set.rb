module ActiveModel
  module ErrorCollecting
    class ErrorMessageSet
      include Enumerable
      delegate :each, :length, to: :@set
      attr_reader :attribute
      def initialize(base, attribute, messages, array)
        @base = base
        @attribute = attribute
        @set = array.map { |element| ErrorMessage.new(@base, @attribute, element) }.to_set
      end

      def <<(element)
        if element.is_a? ErrorMessage
          @set << element
        else
          @set << ErrorMessage.new(@base, @attribute, element)
        end
      end

      def to_a
        @set.to_a
      end
    end
  end
end
