# encoding: utf-8

require 'spec_helper'

describe ErrorMessageSet, '#push' do
  subject { object }

  let(:object)    { described_class.new base, field }
  let(:base)      { User.new }
  let(:field)     { :first_name }

  context 'without options' do
    let(:error)       { :invalid }

    before            { object.push(error) }

    its(:size)        { should eql 1 }

    describe 'first error' do
      subject { object.first }

      it              { should be_a ErrorMessage }
      its(:base)      { should eql base }
      its(:attribute) { should eql field }
      its(:message)   { should be_nil }
      its(:type)      { should eql error }
    end
  end

  context 'with options' do
    let(:error)       { :invalid }
    let(:options)     { { message: 'Invalid' } }

    before            { object.push(error, options) }

    its(:size)        { should eql 1 }

    describe 'first error' do
      subject { object.first }

      it              { should be_a ErrorMessage }
      its(:base)      { should eql base }
      its(:attribute) { should eql field }
      its(:message)   { should eql options[:message] }
      its(:type)      { should eql error }
    end
  end
end
