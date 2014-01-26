# encoding: utf-8

require 'spec_helper'

describe ErrorMessageSet, '#to_a' do
  subject { object.to_a }

  let(:object)    { described_class.new base, field, errors }
  let(:base)      { User.new }
  let(:field)     { :first_name }
  let(:errors)    do
    [
      :invalid,
      'no good',
      { type: :invalid, message: 'no good' }
    ]
  end

  it { should eql object }
  it { should_not equal object }
end
