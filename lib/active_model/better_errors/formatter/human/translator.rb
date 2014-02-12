module ActiveModel
  module BetterErrors
    class Formatter
      class Human
        class Translator
          include AbstractType, Concord.new(:error_message)

          def self.translate(error_message)
            new(error_message).translate
          end

          abstract_method :translate
        end
      end
    end
  end
end
