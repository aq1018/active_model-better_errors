# encoding: utf-8

module ActiveModel
  module BetterErrors
    class Formatter
      class Human
        #
        # Abstract Builder used in Translator to
        # encapsulate common logic and build translations.
        #
        class Builder
          include AbstractType, Concord.new(:error_message)

          def self.build(*args)
            new(*args).build
          end

          def base_error?
            error_message.attribute == :base
          end

          abstract_method :build
        end
      end
    end
  end
end
