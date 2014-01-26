# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#add' do
  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:field)       { :first_name }
  let(:message)     { :invalid }
  let(:options)     { { message: 'no good' } }

  context 'the attribute' do
    subject { object[field] }
    before  { object.add(field, message, options) }

    it { should be_a ErrorMessageSet }
    its(:size) { should eql 1 }
  end

  subject { object[field] }

  context 'with options' do
    subject         { object.add(field, message, options) }

    it              { should be_a ErrorMessage }
    its(:base)      { should eql base }
    its(:attribute) { should eql field }
    its(:type)      { should eql message }
    its(:message)   { should eql options[:message] }
  end

  context 'without options' do
    subject         { object.add(field, message) }

    it              { should be_a ErrorMessage }
    its(:base)      { should eql base }
    its(:attribute) { should eql field }
    its(:type)      { should eql message }
    its(:message)   { should eql nil }
  end
end
