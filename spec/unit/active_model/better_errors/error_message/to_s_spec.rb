# encoding: utf-8

require 'spec_helper'

describe ErrorMessage, '#to_s' do
  subject       { object.to_s }

  let(:object)    { described_class.new base, field, type, message, options }
  let(:base)      { User.new }
  let(:field)     { :first_name }
  let(:options)   { {} }

  context 'when type is nil and message is "no good"' do
    let(:type)      { nil }
    let(:message)   { 'no good' }

    it { should == message }
  end

  context 'when type is :invalid and message is nil' do
    let(:type)      { :invalid }
    let(:message)   { 'is invalid' }

    it { should == message }
  end

  context 'when type is :invalid and message is "no good"' do
    let(:type)      { :invalid }
    let(:message)   { 'no good' }

    it { should == message }
  end
end
