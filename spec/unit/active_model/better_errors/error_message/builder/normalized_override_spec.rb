# encoding: utf-8

require 'spec_helper'

describe ErrorMessage::Builder, '#normalized_override' do

  subject { object.normalized_override }

  let(:object)    { described_class.new(base, attribute, message, options) }
  let(:base)      { User.new }
  let(:attribute) { :name }
  let(:message)   { :foo }
  let(:options)   { { message: override } }

  context 'when override is a symbol' do
    let(:override)  { :invalid }
    let(:expected)  { :invalid }

    it { should eql expected }
  end

  context 'when override is a string' do
    let(:override)  { 'invalid' }
    let(:expected)  { 'invalid' }

    it { should eql expected }
  end

  context 'when override responds to #call' do
    let(:override)  { -> { 'invalid' } }
    let(:expected)  { 'invalid' }

    it { should eql expected }
  end

  context 'when override is nil' do
    let(:override)  { nil }

    it { should be_nil }
  end
end
