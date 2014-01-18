# encoding: utf-8

require 'spec_helper'

describe ErrorMessageSet, '#build_error_message' do
  let(:object)    { described_class.new base, field }
  let(:base)      { User.new }
  let(:field)     { :first_name }

  context 'with options' do
    subject       { object.send :build_error_message, error, options }

    let(:options) { { message: 'OMG!' } }

    context 'when accepting error as a symbol' do
      let(:error)     { :invalid }

      it              { should be_a ErrorMessage }
      its(:base)      { should eql base }
      its(:attribute) { should eql field }
      its(:type)      { should eql error }
      its(:message)   { should eql options[:message] }
    end

    context 'when accepting error as a string' do
      let(:error)     { 'no good' }

      it              { should be_a ErrorMessage }
      its(:base)      { should eql base }
      its(:attribute) { should eql field }
      its(:type)      { should eql nil }
      its(:message)   { should eql 'OMG!' }
    end
  end

  context 'without options' do
    subject       { object.send :build_error_message, error }

    context 'when accepting error as a symbol' do
      let(:error)     { :invalid }

      it              { should be_a ErrorMessage }
      its(:base)      { should eql base }
      its(:attribute) { should eql field }
      its(:type)      { should eql error }
      its(:message)   { should be_nil }
    end

    context 'when accepting error as a string' do
      let(:error)     { 'no good' }

      it              { should be_a ErrorMessage }
      its(:base)      { should eql base }
      its(:attribute) { should eql field }
      its(:type)      { should eql nil }
      its(:message)   { should eql 'no good' }
    end
  end
end
