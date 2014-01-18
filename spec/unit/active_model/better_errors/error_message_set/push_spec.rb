# encoding: utf-8

require 'spec_helper'

describe ErrorMessageSet, '#push' do
  subject         { action }
  let(:action)    { object.push(*errors) }
  let(:object)    { described_class.new base, field }
  let(:base)      { User.new }
  let(:field)     { :first_name }
  let(:errors)    { [:invalid, 'no good', { type: :bad, message: 'no good' }] }

  it { should equal object }
  its(:size) { should eql 3 }

  describe 'the first error' do
    subject { action.first }

    its(:base)      { should equal base }
    its(:attribute) { should equal field }
    its(:type)      { should equal :invalid }
    its(:message)   { should equal nil }
  end

  describe 'the second error' do
    subject { action.second }

    its(:base)      { should equal base }
    its(:attribute) { should equal field }
    its(:type)      { should equal nil }
    its(:message)   { should eql 'no good' }
  end

  describe 'the third error' do
    subject { action.last }

    its(:base)      { should equal base }
    its(:attribute) { should equal field }
    its(:type)      { should equal :bad }
    its(:message)   { should eql 'no good' }
  end
end
