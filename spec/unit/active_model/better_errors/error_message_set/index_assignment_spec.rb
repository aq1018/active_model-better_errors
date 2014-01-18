# encoding: utf-8

require 'spec_helper'

describe ErrorMessageSet, '#[]=' do
  subject { object.first }

  let(:object)    { described_class.new base, field }
  let(:base)      { User.new }
  let(:field)     { :first_name }

  before { object[0] = error }

  describe 'when accepting error as a symbol' do
    let(:error)     { :invalid }

    it              { should be_a ErrorMessage }
    its(:base)      { should eql base }
    its(:attribute) { should eql field }
    its(:type)      { should eql error }
    its(:message)   { should be_nil }
  end

  describe 'when accepting error as a string' do
    let(:error)     { 'no good' }

    it              { should be_a ErrorMessage }
    its(:base)      { should eql base }
    its(:attribute) { should eql field }
    its(:type)      { should eql nil }
    its(:message)   { should eql 'no good' }
  end

  describe 'when accepting error as a tuple' do
    let(:error)     { [:invalid, { message: 'OMG!!' }] }

    it              { should be_a ErrorMessage }
    its(:base)      { should eql base }
    its(:attribute) { should eql field }
    its(:type)      { should eql :invalid }
    its(:message)   { should eql 'OMG!!' }
  end

end
