# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#get' do
  subject { object.get(field) }

  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:field)       { :first_name }

  context 'when errors for attribute is nil' do
    it { should be_nil }
  end

  context 'when errors for attribute is empty' do
    before { object[field] }

    it { should be_a ErrorMessageSet }
    it { should be_empty }
  end

  context 'when errors for attribute contain error' do
    before { object[field] << :invalid }

    it          { should be_a ErrorMessageSet }
    its(:size)  { should eql 1 }
  end
end
