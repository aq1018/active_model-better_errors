# encoding: utf-8
require 'spec_helper'

describe Formatter::Human, '#format_message' do

  subject { object.format_message }

  let(:object)          { described_class.new(error_message) }
  let(:base)            { User.new }
  let(:attribute)       { :first_name }
  let(:builder)         { ErrorMessage::Builder }

  context 'when error_message has type symbol' do
    let(:error_message)   { builder.build(base, attribute, type) }
    let(:type)            { :blank }
    let(:expected)        { 'can\'t be blank' }

    it { should eql expected }
  end

  context 'when error_message has message' do
    let(:error_message)   { builder.build(base, attribute, type, options) }
    let(:options)         { { message: message } }
    let(:type)            { :blank }
    let(:message)         { 'woot? You entered nothing?' }

    it { should eql message }
  end

end
