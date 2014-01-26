# encoding: utf-8

require 'spec_helper'

describe ErrorMessage, '#as_json' do
  let(:object)    { described_class.new base, field, error }
  let(:base)      { User.new }
  let(:field)     { :name }
  let(:error)     { { type: type, message: message, options: options } }
  let(:type)      { :invalid }
  let(:message)   { 'is invalid' }
  let(:options)   { {} }

  let(:expected) do
    {
      attribute: field,
      type: type,
      message: message,
      options: options
    }
  end

  context 'with argument' do
    subject       { object.as_json(foo: :bar) }

    its(:to_hash) { should == expected }
  end

  context 'without argument' do
    subject       { object.as_json }

    its(:to_hash) { should == expected }
  end

end
