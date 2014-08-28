# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#added?' do
  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:field)       { :first_name }
  let(:type)        { :invalid }
  let(:message)     { 'no good' }

  context 'with attribute' do
    before { object[field] << type }

    context 'when attribute is in collection' do
      subject { object.added?(field) }

      it { should be true }
    end

    context 'when attribute is not in collection' do
      subject { object.added?(:not_there) }

      it { should be false }
    end
  end

  context 'with attribute and message' do
    before { object[field] << message }

    context 'when messgage is in collection' do
      subject { object.added?(field, message) }

      it { should be true }
    end

    context 'when message is not in collection' do
      subject { object.added?(field, type) }

      it { should be false }
    end
  end

  context 'with attribute, message, and options' do
    let(:options)     { { message: message } }
    let(:error)       { { type: type, message: message } }

    before { object[field] << error }

    context 'when testing for symbol' do

      subject { object.added?(field, type, options) }

      it { should be true }
    end

    context 'when testing for string' do
      subject { object.added?(field, type, {}) }

      it { should be false }
    end
  end
end
