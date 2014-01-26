# encoding: utf-8

require 'spec_helper'

describe Reporter, '#formatter_for' do

  subject { object.formatter_for(error) }

  let(:object)          { described_class.new(collection, formatter_type) }
  let(:collection)      { ErrorCollection.new(base) }
  let(:formatter_type)  { :foo }
  let(:error)           { double('ErrorMessage') }
  let(:base)            { User.new }
  let(:field)           { :name }
  let(:type)            { :invalid }
  let(:formatter)       { double('Formatter') }

  before do
    ::ActiveModel::BetterErrors.formatters
      .should_receive(:build)
      .with(formatter_type, error)
      .and_return(formatter)
  end

  it { should equal formatter }
end
