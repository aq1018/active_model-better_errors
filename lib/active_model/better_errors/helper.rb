# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # Helper
    #
    module Helper
      METHODS = [
        :formatters,
        :reporters,
        :default_formatter_type,
        :default_formatter_class,
        :reporter_types
      ]
      extend ActiveSupport::Concern

      included do
        class << self
          delegate(*METHODS, to: ::ActiveModel::BetterErrors)
        end

        delegate(*METHODS, to: 'self.class')
      end
    end
  end
end
