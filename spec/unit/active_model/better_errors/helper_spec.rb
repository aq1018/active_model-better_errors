# encoding: utf-8

require 'spec_helper'

describe Helper do
  subject { object }

  let(:klass) do
    Class.new do
      include Helper
    end
  end

  let(:object) { klass.new }
  let(:source) { ActiveModel::BetterErrors }

  its(:formatters) { should be source.formatters }
  its(:reporters) { should be source.reporters }
  its(:default_formatter_type) { should be source.default_formatter_type }
  its(:default_formatter_class) { should be source.default_formatter_class }
  its(:reporter_types) { should be source.reporter_types }
end
