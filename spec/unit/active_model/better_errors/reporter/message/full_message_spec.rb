# encoding: utf-8

require 'spec_helper'

describe Reporter::Message, '#full_message' do

  subject { object.full_message(attribute, message) }

  let(:object)          { described_class.new(collection, formatter_type) }
  let(:collection)      { ErrorCollection.new(base) }
  let(:formatter_type)  { :human }
  let(:base)            { User.new }
  let(:attribute)       { :first_name }

  before do
    base.class
      .stub(:human_attribute_name)
      .with(attribute, default: 'First name')
      .and_return('Given Name')
  end

  context 'when message is not an ErrorMessage' do
    let(:message)         { :empty }
    let(:expected)        { 'Given Name can\'t be empty' }

    it { should eql expected }
  end

  context 'when message is an ErrorMessage' do
    let(:expected)        { 'Given Name is invalid' }
    let(:message) do
      ErrorMessage::Builder.build(base, attribute, :invalid)
    end

    it { should eql expected }
  end
end
