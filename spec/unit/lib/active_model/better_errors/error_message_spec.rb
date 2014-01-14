# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors::ErrorMessage do
  let(:builder)     { ActiveModel::BetterErrors::ErrorMessage::Builder }
  let(:attribute) { :name }
  let(:base)      { User.new }
  subject(:error_message) { builder.build(base, attribute, message, options) }

  describe '#initialize' do
    let(:message) { :invalid }
    let(:options) { { message: 'Invalid!', count: 12 } }

    its(:options)   { should == { count: 12 } }
    its(:attribute) { should == attribute }
  end

  describe '#to_hash' do
    let(:message) { :invalid }
    let(:options) { {} }
    let(:expected) do
      { attribute: attribute, type: :invalid, message: nil, options: {} }
    end

    its(:to_hash) { should == expected }
  end

  describe '#as_json' do
    let(:message) { :invalid }
    let(:options) { {} }
    let(:expected) do
      { attribute: attribute, type: :invalid, message: nil, options: {} }
    end

    it 'should respond to as_json taking json arguments' do
      subject.as_json(test: :arguments).should == expected
    end
  end

  describe '#<=>' do
    subject { e1 <=> e2 }

    context 'when attribute is different' do
      let(:e1) { builder.build base, :name, :invalid }
      let(:e2) { builder.build base, :name1, :invalid }
      it { should be_nil }
    end

    context 'when type is different' do
      let(:e1) { builder.build base, :name, :invalid }
      let(:e2) { builder.build base, :name, :invalid1 }
      it { should be_nil }
    end

    context 'when message is different' do
      let(:e1) { builder.build base, :name, :invalid, message: 'a' }
      let(:e2) { builder.build base, :name, :invalid, message: 'b' }
      it { should be_nil }
    end

    context 'when it is the same' do
      let(:e1) { builder.build base, :name, :invalid }
      let(:e2) { builder.build base, :name, :invalid }
      it { should == 0 }
    end
  end
end
