module ActiveModel
  module ErrorCollecting
    class ErrorMessage
      attr_reader :attribute, :key, :message, :options
      def initialize(base, attribute, message, options = {})
        @base = base
        @attribute = attribute
        @options = options
        case message
        when Array
          @key, @message = message
        when Symbol
          @key = message
        else
          ActiveSupport::Deprecation.warn("Using strings with errors#add is not supported by BetterErrors, use [:invalid, 'this is invalid'] instead.")
          @message = message.to_s
        end
      end

      def human?
        message.present?
      end

      def robot?
        key.present?
      end

      def to_s
        message
      end

      # Translates an error message in its default scope
      # (<tt>activemodel.errors.messages</tt>).
      #
      # Error messages are first looked up in <tt>models.MODEL.attributes.ATTRIBUTE.MESSAGE</tt>,
      # if it's not there, it's looked up in <tt>models.MODEL.MESSAGE</tt> and if
      # that is not there also, it returns the translation of the default message
      # (e.g. <tt>activemodel.errors.messages.MESSAGE</tt>). The translated model
      # name, translated attribute name and the value are available for
      # interpolation.
      #
      # When using inheritance in your models, it will check all the inherited
      # models too, but only if the model itself hasn't been found. Say you have
      # <tt>class Admin < User; end</tt> and you wanted the translation for
      # the <tt>:blank</tt> error message for the <tt>title</tt> attribute,
      # it looks for these translations:
      #
      # * <tt>activemodel.errors.models.admin.attributes.title.blank</tt>
      # * <tt>activemodel.errors.models.admin.blank</tt>
      # * <tt>activemodel.errors.models.user.attributes.title.blank</tt>
      # * <tt>activemodel.errors.models.user.blank</tt>
      # * any default you provided through the +options+ hash (in the <tt>activemodel.errors</tt> scope)
      # * <tt>activemodel.errors.messages.blank</tt>
      # * <tt>errors.attributes.title.blank</tt>
      # * <tt>errors.messages.blank</tt>
      def message
        return @message if @message
        if @base.class.respond_to?(:i18n_scope)
          defaults = @base.class.lookup_ancestors.map do |klass|
            [ :"#{@base.class.i18n_scope}.errors.models.#{klass.model_name.i18n_key}.attributes.#{attribute}.#{key}",
              :"#{@base.class.i18n_scope}.errors.models.#{klass.model_name.i18n_key}.#{key}" ]
          end
        else
          defaults = []
        end

        defaults << options.delete(:message)
        defaults << :"#{@base.class.i18n_scope}.errors.messages.#{key}" if @base.class.respond_to?(:i18n_scope)
          defaults << :"errors.attributes.#{attribute}.#{key}"
          defaults << :"errors.messages.#{key}"

          defaults.compact!
        defaults.flatten!

        i18n_key = defaults.shift

        options.reverse_merge!(
          :default => defaults,
          :model => @base.class.model_name.human,
          :attribute => @base.class.human_attribute_name(attribute)
        )

        I18n.translate(i18n_key, options)
      end
    end
  end
end
