# encoding: utf-8

require 'spec_helper'

describe ErrorMessage::Builder, '#override' do

  subject { object.override }

  let(:object)    { described_class.new(base, attribute, message, options) }
  let(:base)      { User.new }
  let(:attribute) { :name }
  let(:message)   { :invalid }
  let(:options)   { { message: override } }
  let(:override)  { :foo }

  it { should be override }

  it 'deletes options[:message]' do
    subject
    expect(object.options).to_not include(:message)
  end

  it 'memoizes' do
    o1 = object.override
    o2 = object.override
    expect(o2).to be(o1)
  end
end
