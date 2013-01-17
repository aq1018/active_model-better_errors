module ActiveModel
  module ErrorCollecting
    class HumanMessageFormatter
      include Forwardable

      def_delegators :@error_message, :attribute, :type, :message, :options

      def initialize(base, error_message)
        @base, @error_message = base, error_message
      end

      def format_message
        keys = i18n_keys
        key  = keys.shift

        options = {
          :default => keys,
          :model => @base.class.model_name.human,
          :attribute => @base.class.human_attribute_name(attribute),
          :value => attribute_value
        }.merge(options)

        I18n.translate(key, options)
      end

      private

      def attribute_value
        attribute != :base ? @base.send(:read_attribute_for_validation, attribute) : nil
      end

      def i18n_keys
        if @base.class.respond_to?(:i18n_scope)
          keys = @base.class.lookup_ancestors.map do |klass|
            [ :"#{@base.class.i18n_scope}.errors.models.#{klass.model_name.i18n_key}.attributes.#{attribute}.#{type}",
              :"#{@base.class.i18n_scope}.errors.models.#{klass.model_name.i18n_key}.#{type}" ]
          end
        else
          keys = []
        end
        keys << message
        keys << :"#{@base.class.i18n_scope}.errors.messages.#{type}" if @base.class.respond_to?(:i18n_scope)
        keys << :"errors.attributes.#{attribute}.#{type}"
        keys << :"errors.messages.#{type}"

        keys.compact!
        keys.flatten!
        keys
      end
    end
  end
end