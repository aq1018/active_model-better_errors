# encoding: utf-8

require 'spec_helper'

describe Emulation, '#add' do
  include Helper

  subject { collection[attribute].first }

  let(:klass) do
    Struct.new(
      :base,
      :error_collection,
      :message_reporter,
      :hash_reporter,
      :array_reporter
    )
  end

  let(:object) do
    klass.new(
      base,
      collection,
      message_reporter,
      hash_reporter,
      array_reporter
    )
  end

  before { klass.send :include, described_class }

  let(:base) { User.new }
  let(:collection) { ErrorCollection.new(base) }
  let(:message_reporter) { reporters.build(:message, collection, :human) }
  let(:hash_reporter) { reporters.build(:hash, collection, :machine) }
  let(:array_reporter) { reporters.build(:array, collection, :machine) }

  let(:attribute) { :first_name }
  let(:type)      { :blank }
  let(:options)   { { message: message } }
  let(:message)   { 'oops' }

  context 'without strict option' do
    before { object.add(attribute, type, options) }

    its(:type) { should be type }
    its(:message) { should eql message }
  end

  context 'with strict option' do
    let(:options)   { { message: message, strict: true } }

    it 'raises ActiveModel::StrictValidationFailed' do
      expect { object.add(attribute, type, options) }.to raise_error(
        ::ActiveModel::StrictValidationFailed,
        'First name oops'
      )
    end

    context 'without message' do
      let(:options)   { { strict: true } }

      it 'raises ActiveModel::StrictValidationFailed' do
        expect { object.add(attribute, type, options) }.to raise_error(
          ::ActiveModel::StrictValidationFailed,
          'First name can\'t be blank'
        )
      end
    end
  end

  context 'with default message' do
    before { object.add(attribute) }

    its(:type) { should be nil }
    its(:message) { should be nil }
  end
end
