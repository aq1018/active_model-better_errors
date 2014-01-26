# encoding: utf-8

require 'spec_helper'

describe ErrorMessage, '#options' do
  subject       { object.options }

  let(:object)    { described_class.new base, field, error }
  let(:base)      { User.new }
  let(:field)     { :name }
  let(:error)     { { type: type, message: message, options: options } }
  let(:type)      { :invalid }
  let(:message)   { 'is invalid' }

  context 'without options' do
    let(:options)   { nil }
    it { should eql Hash.new }
  end

  context 'with options' do
    let(:options)   { { foo: :bar } }
    it { should eql options }
  end
end
