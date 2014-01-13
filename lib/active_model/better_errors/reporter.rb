# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # Reporter
    #
    class Reporter
      include Helper, Concord.new(:collection, :formatter_type)

      delegate :base, to: :collection

      def formatter_for(error_message)
        formatters.build(formatter_type, error_message)
      end
    end
  end
end
