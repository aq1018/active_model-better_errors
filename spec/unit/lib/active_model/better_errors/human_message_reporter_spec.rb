# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors::HumanMessageReporter do
  subject { reporter }
  let(:reporter)    { klass.new collection }
  let(:klass)       { ActiveModel::BetterErrors::HumanMessageReporter }
  let(:collection)  { ActiveModel::BetterErrors::ErrorCollection.new base }
  let(:base)        { User.new }

  describe '#initialize' do
    its(:collection) { should be collection }
  end

  describe '#base' do
    its(:base) { should be base }
  end

  describe '#full_message' do
    subject { reporter.full_message attribute, message }
    let(:attribute) { :first_name }
    let(:message)   { 'is invalid' }

    it { should == 'First name is invalid' }
  end

  describe '#full_messages' do
    subject { reporter.full_messages }
    let(:expected) do
      [
        'First name is invalid',
        "First name can't be empty",
        'Last name is invalid'
      ]
    end

    before  do
      collection[:first_name] << :invalid
      collection[:first_name] << :empty
      collection[:last_name] << :invalid
    end

    it { should == expected }
  end

  describe '#generate_message' do
    subject { reporter.generate_message attribute, type, options }
    let(:attribute) { :first_name }

    context 'when passing symbols as message' do
      let(:type)      { :too_short }
      let(:options)   { { count: 3 } }
      let(:expected)  { 'is too short (minimum is 3 characters)' }
      it { should == expected }
    end

    context 'when passing strings as message' do
      let(:type)      { 'foo' }
      let(:options)   { nil }
      let(:expected)  { type }
      it { should == expected }
    end
  end
end
