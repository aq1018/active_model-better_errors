# encoding: utf-8

require 'spec_helper'

describe Reporter::Message, '#generate_message' do
  let(:object)          { described_class.new(collection, formatter_type) }
  let(:collection)      { ErrorCollection.new(base) }
  let(:formatter_type)  { :human }
  let(:base)            { User.new }
  let(:attribute)       { :first_name }

  context 'when pass in attribute only' do
    subject { object.generate_message(attribute) }

    let(:expected) { 'is invalid' }

    it { should eql expected }
  end

  context 'when pass in attribute and type' do
    subject { object.generate_message(attribute, type) }

    let(:type) { :blank }
    let(:expected) { 'can\'t be blank' }

    it { should eql expected }
  end

  context 'when pass in attribute and nil type' do
    subject { object.generate_message(attribute, type) }

    let(:formatter_type)  { :machine }
    let(:type) { nil }
    let(:expected) { { message: :invalid, options: {} } }

    it { should eql expected }
  end

  context 'when pass in attribute and type' do
    subject { object.generate_message(attribute, type, options) }

    let(:type) { :too_short }
    let(:options) { { count: 5 } }
    let(:expected) { 'is too short (minimum is 5 characters)' }

    it { should eql expected }
  end
end
