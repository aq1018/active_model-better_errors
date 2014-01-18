# encoding: utf-8

require 'spec_helper'

describe ErrorMessageSet, '#initialize' do
  subject { object }

  let(:object)    { described_class.new base, field, errors }
  let(:base)      { User.new }
  let(:field)     { :first_name }
  let(:errors)    { [:invalid, 'no good', [:invalid, { message: 'no good' }]] }

  it              { should be_a Array }
  its(:base)      { should eql base }
  its(:attribute) { should eql field }
  its(:size)      { should eql errors.size }

  describe 'first error' do
    subject { object[0] }

    it { should be_a ErrorMessage }
    its(:type)    { should eql :invalid }
    its(:message) { should be_nil }
  end

  describe 'second error' do
    subject { object[1] }

    it { should be_a ErrorMessage }
    its(:type)    { should be_nil }
    its(:message) { should eql 'no good' }
  end

  describe 'thrid error' do
    subject { object[2] }

    it { should be_a ErrorMessage }
    its(:type)    { should be :invalid }
    its(:message) { should eql 'no good' }
  end

  describe 'when errors is empty array' do
    let(:errors) { [] }

    its(:size) { should eql 0 }
  end

  describe 'when ommitting errors' do
    let(:object) { described_class.new base, field }

    its(:size) { should eql 0 }
  end
end
