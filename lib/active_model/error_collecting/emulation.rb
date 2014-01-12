#
# Allows included class to emulate ActiveModel::Errors class
# by defining a set of methods to delegate to facilities
# in this gem.
#
module ActiveModel
  module ErrorCollecting
    module Emulation
      MODEL_METHODS = [
        :clear, :include?, :get, :set, :delete, :[], :[]=,
        :each, :size, :values, :keys, :count, :empty?, :any?,
        :added?, :entries
      ]

      MESSAGE_REPORTER_METHODS = [
        :full_messages, :full_message, :generate_message
      ]

      def self.included(base)
        base.class_eval do
          extend Forwardable
          def_delegators :error_collection, *MODEL_METHODS
          def_delegators :message_reporter, *MESSAGE_REPORTER_METHODS
          def_delegators :hash_reporter,    :to_hash
          def_delegators :array_reporter,   :to_a

          alias_method :blank?, :empty?
          alias_method :has_key?, :include?
        end
      end

      def add_on_empty(attributes, options = {})
        [attributes].flatten.each do |attribute|
          value = @base.send(:read_attribute_for_validation, attribute)
          is_empty = value.respond_to?(:empty?) ? value.empty? : false
          add(attribute, :empty, options) if value.nil? || is_empty
        end
      end

      def add_on_blank(attributes, options = {})
        [attributes].flatten.each do |attribute|
          value = @base.send(:read_attribute_for_validation, attribute)
          add(attribute, :blank, options) if value.blank?
        end
      end

      def add(attribute, message=nil, options = {})
        if options[:strict]
          error   = ErrorMessage.build(attribute, message, options)
          message = ::ActiveModel::ErrorCollecting.format_message(@base, error)
          raise ActiveModel::StrictValidationFailed, full_message(attribute, message)
        end
        error_collection.add attribute, message, options
      end

      def to_xml(options={})
        to_a.to_xml options.reverse_merge(:root => "errors", :skip_types => true)
      end

      def as_json(options=nil)
        to_hash
      end
    end
  end
end