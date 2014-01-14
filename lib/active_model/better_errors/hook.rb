# coding: utf-8

module ActiveModel
  #
  # ActiveModel::Validations#errors override
  #
  module Validations
    def errors
      @errors ||= BetterErrors::Errors.new(self)
    end
  end
end
