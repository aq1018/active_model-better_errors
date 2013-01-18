require 'active_model/error_collecting/error_message'
require 'active_model/error_collecting/error_message_set'
require 'active_model/error_collecting/error_collection'
require 'active_model/error_collecting/human_message_formatter'
require 'active_model/error_collecting/human_message_reporter'
require 'active_model/error_collecting/human_hash_reporter'
require 'active_model/error_collecting/human_array_reporter'
require 'active_model/error_collecting/machine_hash_reporter'
require 'active_model/error_collecting/machine_array_reporter'
require 'active_model/error_collecting/emulation'
require 'active_model/error_collecting/errors'

module ActiveModel
  module ErrorCollecting
    class << self
      def set_reporter(name, reporter_class)
        name = name.to_s
        @reporter_maps ||= {}
        @reporter_maps[name] = reporter_class
        @reporter_maps.delete(name) unless reporter_class
      end

      def reporters
        @reporter_maps ||= {}
        @reporter_maps.clone
      end
    end

    set_reporter :message,  HumanMessageReporter
    set_reporter :array,    HumanArrayReporter
    set_reporter :hash,     HumanHashReporter
  end
end
