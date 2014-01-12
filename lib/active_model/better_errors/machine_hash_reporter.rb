# encoding: utf-8

module ActiveModel
  module BetterErrors
    #
    # MachineHashReporter
    #
    class MachineHashReporter < HashReporter
      def to_hash
        collection.to_hash.reduce({}) do |hash, kv|
          attribute, error_message_set = kv
          hash[attribute] = error_message_set.map do |error_message|
            format_error_message(error_message)
          end
          hash
        end
      end

      def format_error_message(error_message)
        result = {}
        result[:type] = error_message.type || :invalid

        options = error_message.options
        result[:options] = options unless options.blank?
        result
      end
    end
  end
end
