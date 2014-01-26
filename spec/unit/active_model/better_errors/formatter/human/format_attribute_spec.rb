# encoding: utf-8

require 'spec_helper'

describe Formatter::Human, '#format_attribute' do

  subject { object.format_attribute }

  let(:object)          { described_class.new(error_message) }
  let(:error_message)   { ErrorMessage::Builder.build(base, attribute, :foo) }
  let(:base)            { User.new }

  context 'when attribute is :first_name' do
    let(:attribute)       { :first_name }
    let(:expected)        { 'First name' }
    it { should eql expected }
  end

  context 'when attribute is :first.name' do
    let(:attribute)       { :'first.name.test' }
    let(:expected)        { 'First name test' }
    it { should eql expected }
  end

  context 'when attribute has translation' do
    let(:attribute)       { :first_name }
    let(:expected)        { 'Given name' }

    before do
      base.class
        .should_receive(:human_attribute_name)
        .with(attribute, default: 'First name')
        .and_return(expected)
    end

    it { should eql expected }
  end

end
