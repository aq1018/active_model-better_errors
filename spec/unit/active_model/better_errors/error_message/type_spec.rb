# encoding: utf-8

require 'spec_helper'

describe ErrorMessage, '#type' do
  subject       { object.type }

  let(:object)    { described_class.new base, field, error }
  let(:base)      { User.new }
  let(:field)     { :name }
  let(:error)     { { type: type, message: message, options: options } }
  let(:type)      { :invalid }
  let(:message)   { 'is invalid' }
  let(:options)   { {} }

  it { should eql type }
end
