require 'active_model/error_collecting/error_message'
require 'active_model/error_collecting/error_message_set'
require 'active_model/error_collecting/error_collection'

require 'active_model/error_collecting/reporter'
require 'active_model/error_collecting/message_reporter'
require 'active_model/error_collecting/hash_reporter'
require 'active_model/error_collecting/array_reporter'

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
      def set_reporter(name, reporter)
        name = name.to_s
        @reporter_maps ||= {}
        return @reporter_maps.delete(name) unless reporter
        @reporter_maps[name] = get_reporter_class(name, reporter)
      end

      def reporters
        @reporter_maps ||= {}
        @reporter_maps.clone
      end

      def get_reporter_class(name, reporter)
        return reporter if reporter.is_a? Class
        class_name = "active_model/error_collecting/#{reporter}_#{name}_reporter"
        class_name.classify.constantize
      end
    end

    set_reporter :message,  :human
    set_reporter :array,    :human
    set_reporter :hash,     :human
  end
end
