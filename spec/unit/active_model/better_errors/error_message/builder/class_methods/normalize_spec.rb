# encoding: utf-8

require 'spec_helper'

describe ErrorMessage::Builder, '.normalize' do

  subject { described_class.normalize(message) }

  context 'with a symbol' do
    let(:message)   { :invalid }
    let(:expected)  { :invalid }

    it { should eql expected }
  end

  context 'with a string' do
    let(:message)   { 'invalid' }
    let(:expected)  { 'invalid' }

    it { should eql expected }
  end

  context 'with a lambda' do
    let(:message)   { -> { 'invalid' } }
    let(:expected)  { 'invalid' }

    it { should eql expected }
  end

  context 'with nil' do
    let(:message)   { nil }
    let(:expected)  { nil }

    it { should eql expected }
  end
end
