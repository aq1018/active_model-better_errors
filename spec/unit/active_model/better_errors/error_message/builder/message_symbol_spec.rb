# encoding: utf-8

require 'spec_helper'

describe ErrorMessage::Builder, '#message_symbol' do

  subject { object.message_symbol }

  let(:object)    { described_class.new(base, attribute, message, options) }
  let(:base)      { User.new }
  let(:attribute) { :name }
  let(:options)   { { message: override } }

  context 'when override is a symbol' do
    let(:override)  { :bar }
    let(:message)   { :foo }
    let(:expected)  { :bar }

    it { should eql expected }
  end

  context 'when override is not a symbol' do
    let(:override)  { 'bar' }

    context 'and when message is a symbol' do
      let(:message)   { :foo }
      let(:expected)  { :foo }

      it { should eql expected }
    end

    context 'and when message is not a symbol' do
      let(:message)   { 'foo' }
      let(:expected)  { nil }

      it { should eql expected }
    end
  end
end
