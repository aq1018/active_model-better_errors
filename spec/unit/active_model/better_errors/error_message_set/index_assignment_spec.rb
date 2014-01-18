# encoding: utf-8

require 'spec_helper'

# TODO
#  kill mutants
describe ErrorMessageSet, '#[]=' do
  subject         { object[0] }
  let(:object)    { described_class.new base, field }
  let(:base)      { User.new }
  let(:field)     { :first_name }

  before { object[0] = error }

  describe 'with a symbol' do
    let(:error)  { :invalid }

    it              { should be_a ErrorMessage }
    its(:base)      { should equal base }
    its(:attribute) { should equal field }
    its(:type)      { should equal error }
    its(:message)   { should equal nil }
  end

  describe 'with a string' do
    let(:error)  { 'no good' }

    it              { should be_a ErrorMessage }
    its(:base)      { should equal base }
    its(:attribute) { should equal field }
    its(:type)      { should equal nil }
    its(:message)   { should eql error }
  end

  describe 'with a tuple' do
    let(:error)     { { type: type, message: message } }
    let(:type)      { :invalid }
    let(:message)   { 'no good' }

    its(:base)      { should equal base }
    its(:attribute) { should equal field }
    its(:type)      { should equal type }
    its(:message)   { should eql message }
  end
end
