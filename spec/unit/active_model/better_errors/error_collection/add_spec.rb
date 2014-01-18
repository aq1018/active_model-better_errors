# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#add' do
#  subject { object[field].first }

  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:field)       { :first_name }
  let(:message)     { :invalid }
  let(:options)     { { message: 'no good' } }

  context 'with options' do
    subject       { object.add(field, message, options) }

    it            { should be_a ErrorMessage }
    its(:type)    { should eql message }
    its(:message) { should eql options[:message] }
  end

  context 'without options' do
    subject       { object.add(field, message) }

    it            { should be_a ErrorMessage }
    its(:type)    { should eql message }
    its(:message) { should eql nil }
  end
end
