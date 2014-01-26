# encoding: utf-8

require 'spec_helper'

describe Formatter::Human, '#format_attribute' do

  subject { object.format_attribute }

  let(:object)          { described_class.new(error_message) }
  let(:error_message)   { ErrorMessage::Builder.build(base, attribute, :foo) }
  let(:base)            { User.new }
  let(:attribute)       { :first_name }
  let(:expected)        { 'First name' }

  it { should eql expected }
end
