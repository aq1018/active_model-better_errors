# encoding: utf-8

require 'spec_helper'

# TODO
#  kill mutants
describe ErrorCollection, '#[]=' do
  subject { object[field] }

  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:field)       { :first_name }
  let(:errors)      { [:invalid] }

  before { object[field] = errors }

  it { should be_a ErrorMessageSet }
  its(:size)    { should eql 1 }
end
