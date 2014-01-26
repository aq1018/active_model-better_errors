# encoding: utf-8

require 'spec_helper'

# TODO
#  kill mutants
describe ErrorMessageSet, '#build_error_message' do
  subject         { object.send :build_error_message, error }

  let(:object)    { described_class.new base, field }
  let(:base)      { User.new }
  let(:field)     { :first_name }

  context 'when error is an ErrorMessage' do
    let(:error)   { ErrorMessage::Builder.build(base, field, :invalid) }

    it { should equal error }
    its(:base) { should eql base }
    its(:attribute) { should eql field }
  end

  context 'when error is a symbol' do
    let(:error)     { :invalid }

    it { should be_a ErrorMessage }
    its(:base) { should eql base }
    its(:attribute) { should eql field }
    its(:type)    { should eql error }
    its(:message) { should be_nil }
  end

  context 'when error is a Hash' do
    let(:error)   { { type: type, message: message } }
    let(:type)    { :invalid }
    let(:message) { 'no good' }

    it { should be_a ErrorMessage }
    its(:base) { should eql base }
    its(:attribute) { should eql field }
    its(:type) { should eql type }
    its(:message) { should eql message }
  end

  context 'when error is a string' do
    let(:error)   { 'no good' }

    it { should be_a ErrorMessage }
    its(:base) { should eql base }
    its(:attribute) { should eql field }
    its(:type) { should be_nil }
    its(:message) { should eql error }
  end

  context 'when error is not hash, symbol, or string' do
    let(:error)   { Object.new }

    it 'raises error' do
      expect { subject }.to raise_error(
        ArgumentError,
        'error must be a hash, symbol, or string.'
      )
    end
  end
end
