module ActiveModel
  module BetterErrors
    class Formatter
      class Human
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
