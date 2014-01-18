# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # ErrorMessageSet
    #
    class ErrorMessageSet < Array
      attr_reader :base, :attribute

      def initialize(base, attribute, errors = nil)
        @base      = base
        @attribute = attribute
        push(*errors)
      end

      def []=(*args)
        errors = args.pop

        if errors.is_a?(Array)
          errors = errors.map { |error| build_error_message(error) }
        else
          # singular this case
          errors = build_error_message(errors)
        end

        args = args.push(errors)

        super(*args)
      end

      def <<(error)
        error_message = build_error_message(error)
        super(error_message)
      end

      def push(*args)
        errors = args.map { |error| build_error_message(error) }
        super(*errors)
      end

      def insert(index, *args)
        errors = args.map { |error| build_error_message(error) }
        super(index, *errors)
      end

      def to_a
        dup
      end

      private

      def build_error_message(error)
        return error if error.is_a?(ErrorMessage)

        if error.is_a?(Hash)
          message, options = error.delete(:type), error
        elsif error.is_a?(Symbol)
          message = error
        else
          message = error.to_s
        end
        ErrorMessage::Builder.build(base, attribute, message, options)
      end
    end
  end
end
