# encoding: utf-8

require 'spec_helper'

describe Formatter::Machine, '#format_attribute' do

  subject { object.format_full_message }

  let(:object)          { described_class.new(error_message) }
  let(:error_message)   { ErrorMessage::Builder.build(base, attribute, type) }
  let(:base)            { User.new }
  let(:attribute)       { :first_name }
  let(:type)            { :foo }

  let(:expected) { { attribute: attribute, message: type, options: {} } }

  it { should eql expected }
end
