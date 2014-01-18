# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#set' do
  subject { object[field] }

  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:field)       { :first_name }

  before { object.set(field, errors) }

  context 'with a list of errors' do
    let(:errors)      { [:invalid] }

    it                { should be_a ErrorMessageSet }
    its(:base)        { should eql base }
    its(:attribute)   { should eql field }
    its(:size)        { should eql 1 }
  end

  context 'with errors set to nil' do
    let(:errors)      { nil }

    it                { should be_a ErrorMessageSet }
    its(:base)        { should eql base }
    its(:attribute)   { should eql field }
    its(:size)        { should eql 0 }
  end

  context 'when attribute already has errors' do
    subject           { object.set(field, nil) }
    let(:errors)      { [:invalid] }

    it { should be_a ErrorMessageSet }
    its(:size) { should eql 1 }
  end
end
