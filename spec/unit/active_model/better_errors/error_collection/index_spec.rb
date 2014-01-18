# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#[]' do
  subject { object[field] }

  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:field)       { :first_name }

  context 'with no existing errors' do
    it { should be_a ErrorMessageSet }
    it { should be_blank }
  end

  context 'with pre-existing errors' do
    before        { object.set(field, errors) }

    let(:errors)  { [:invalid] }

    it            { should be_a ErrorMessageSet }
    its(:size)    { should eql 1 }
  end
end
