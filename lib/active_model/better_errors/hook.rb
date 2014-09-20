# coding: utf-8

module ActiveModel
  #
  # ActiveModel::Validations#errors override
  #
  module Validations
    remove_method :errors

    def errors
      @errors ||= BetterErrors::Errors.new(self)
    end
  end
end
