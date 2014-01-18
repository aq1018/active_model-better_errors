# encoding: utf-8

require 'spec_helper'

describe ErrorMessageSet, '#<<' do
  subject { action }

  let(:action)    { object << error }
  let(:object)    { described_class.new base, field }
  let(:base)      { User.new }
  let(:field)     { :first_name }

  context 'when accepting error as a symbol' do
    let(:error)     { :invalid }

    it { should equal object }
    its(:size) { should eql 1 }

    describe 'its error message' do
      subject { action.first }

      its(:base)      { should eql base }
      its(:attribute) { should eql field }
      its(:type)      { should eql error }
      its(:message)   { should be_nil }
    end

  end

  context 'when accepting error as a string' do
    let(:error)     { 'no good' }

    it { should equal object }
    its(:size) { should eql 1 }

    describe 'its error message' do
      subject { action.first }

      its(:base)      { should eql base }
      its(:attribute) { should eql field }
      its(:type)      { should eql nil }
      its(:message)   { should eql 'no good' }
    end
  end

  context 'when accepting error as a tuple' do
    let(:error)     { { type: :invalid, message: 'OMG!!' } }

    it { should equal object }
    its(:size) { should eql 1 }

    describe 'its error message' do
      subject { action.first }

      its(:base)      { should eql base }
      its(:attribute) { should eql field }
      its(:type)      { should eql :invalid }
      its(:message)   { should eql 'OMG!!' }
    end
  end

end
