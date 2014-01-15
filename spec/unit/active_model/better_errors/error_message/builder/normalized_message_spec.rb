# encoding: utf-8

require 'spec_helper'

describe ErrorMessage::Builder, '#normalized_message' do

  subject { object.normalized_message }

  let(:object)    { described_class.new(base, attribute, message, options) }
  let(:base)      { User.new }
  let(:attribute) { :name }
  let(:options)   { {} }

  context 'when message is a symbol' do
    let(:message)   { :invalid }
    let(:expected)  { :invalid }

    it { should eql expected }
  end

  context 'when message is a string' do
    let(:message)   { 'invalid' }
    let(:expected)  { 'invalid' }

    it { should eql expected }
  end

  context 'when message responds to #call' do
    let(:message)   { -> { 'invalid' } }
    let(:expected)  { 'invalid' }

    it { should eql expected }
  end

  context 'when message is nil' do
    let(:message)   { nil }
    let(:expected)  { nil }

    it { should eql expected }
  end
end
