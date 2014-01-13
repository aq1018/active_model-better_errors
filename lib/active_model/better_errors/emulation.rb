# encoding: utf-8

#
# Allows included class to emulate ActiveModel::Errors class
# by defining a set of methods to delegate to facilities
# in this gem.
#
module ActiveModel
  module BetterErrors
    #
    # Emulation
    # Provides a compatible interface to ActiveModel::Errors
    #
    module Emulation
      MODEL_METHODS = [
        :clear, :include?, :get, :set, :delete, :[], :[]=,
        :each, :size, :values, :keys, :count, :empty?, :any?,
        :added?, :entries
      ]

      MESSAGE_REPORTER_METHODS = [
        :full_messages, :full_messages_for, :full_message, :generate_message
      ]

      HASH_REPORTER_METHODS = [
        :to_hash
      ]

      ARRAY_REPORTER_METHODS = [
        :to_a
      ]

      def self.included(base)
        base.class_eval do
          delegate(*MODEL_METHODS, to: :error_collection)
          delegate(*MESSAGE_REPORTER_METHODS, to: :message_reporter)
          delegate(*HASH_REPORTER_METHODS, to: :hash_reporter)
          delegate(*ARRAY_REPORTER_METHODS, to: :array_reporter)

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

      def add(attribute, message = nil, options = {})
        if options[:strict]
          error   = ErrorMessage.build(attribute, message, options)
          message = ::ActiveModel::BetterErrors.format_message(@base, error)
          full_message = full_message(attribute, message)
          fail ActiveModel::StrictValidationFailed, full_message
        end
        error_collection.add attribute, message, options
      end

      def to_xml(options = {})
        to_a.to_xml options.reverse_merge(root: 'errors', skip_types: true)
      end

      def as_json(options = nil)
        to_hash
      end
    end
  end
end
