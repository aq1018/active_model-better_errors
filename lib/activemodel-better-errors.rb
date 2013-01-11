require 'active_model/validations'
require 'active_model/better_errors/api_errors'
require 'active_model/better_errors/proxy'
require 'active_model/better_errors'

module ActiveModel
  module Validations
    def errors
      @errors ||= BetterErrors::Proxy.new(self)
    end
  end
end