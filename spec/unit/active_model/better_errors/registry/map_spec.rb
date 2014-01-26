# encoding: utf-8

require 'spec_helper'

describe Registry, '#map' do
  subject         { object.map }

  let(:object)    { described_class.new }

  it { should eql Hash.new }

  it 'memoizes' do
    subject
    expect(object.instance_variable_get(:@map)).to eql subject
  end

end
