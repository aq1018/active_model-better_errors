# encoding: utf-8

require 'spec_helper'

describe ErrorMessageSet, '#build_error_message' do
  subject         { object.send :build_error_message, error }

  let(:object)    { described_class.new base, field }
  let(:error)     { { type: type, message: message } }
  let(:base)      { User.new }
  let(:field)     { :first_name }

  context 'with message' do
    let(:message) { 'OMG!' }

    context 'when accepting type as a symbol' do
      let(:type)      { :invalid }

      it              { should be_a ErrorMessage }
      its(:base)      { should eql base }
      its(:attribute) { should eql field }
      its(:type)      { should eql type }
      its(:message)   { should eql message }
    end

    context 'when accepting type as a string' do
      let(:type)      { 'no good' }

      it              { should be_a ErrorMessage }
      its(:base)      { should eql base }
      its(:attribute) { should eql field }
      its(:type)      { should eql nil }
      its(:message)   { should eql message }
    end
  end

  context 'without message' do
    let(:message) { nil }

    context 'when accepting type as a symbol' do
      let(:type)      { :invalid }

      it              { should be_a ErrorMessage }
      its(:base)      { should eql base }
      its(:attribute) { should eql field }
      its(:type)      { should eql type }
      its(:message)   { should be_nil }
    end

    context 'when accepting type as a string' do
      let(:type)      { 'no good' }

      it              { should be_a ErrorMessage }
      its(:base)      { should eql base }
      its(:attribute) { should eql field }
      its(:type)      { should eql nil }
      its(:message)   { should eql type }
    end
  end
end
