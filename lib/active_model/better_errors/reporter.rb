# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # Abstract Reporter used to interface with
    # various ActiveModel::Errors methods
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
