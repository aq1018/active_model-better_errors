# encoding: utf-8

require 'spec_helper'

describe ErrorMessage::Builder, '#message_string' do

  subject { object.message_string }

  let(:object)    { described_class.new(base, attribute, message, options) }
  let(:base)      { User.new }
  let(:attribute) { :name }
  let(:message)   { :foo }
  let(:options)   { { message: override } }

  context 'when override is a string' do
    let(:override)  { 'bar' }
    let(:expected)  { 'bar' }

    it { should eql expected }
  end

  context 'and when override is blank' do
    let(:override)   { '' }
    let(:expected)  { nil }

    it { should eql expected }
  end

  context 'when override is not a string' do
    let(:override)  { :bar }

    context 'and when message is a string' do
      let(:message)   { 'foo' }
      let(:expected)  { 'foo' }

      it { should eql expected }
    end

    context 'and when message is blank' do
      let(:message)   { '' }
      let(:expected)  { nil }

      it { should eql expected }
    end

    context 'and when message is not a string' do
      let(:message)   { :foo }
      let(:expected)  { nil }

      it { should eql expected }
    end
  end
end
