# encoding: utf-8

require 'spec_helper'

describe ErrorMessage::Builder, '#build' do

  subject { object.build }

  let(:object)    { described_class.new(base, attribute, message, options) }
  let(:base)      { User.new }
  let(:attribute) { :name }
  let(:message)   { :invalid }
  let(:options)   { {} }

  it              { should be_a ErrorMessage }
  its(:base)      { should eql base }
  its(:attribute) { should eql attribute }
  its(:type)      { should eql object.message_symbol }
  its(:message)   { should eql object.message_string }
  its(:options)   { should eql Hash.new }
end
