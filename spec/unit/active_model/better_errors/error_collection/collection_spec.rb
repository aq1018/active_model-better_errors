# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#collection' do
  subject { object.send :collection }

  let(:object)      { described_class.new base }
  let(:base)        { User.new }

  it { should eql({}) }

  it 'memoizes' do
    expect(subject).to equal(object.send(:collection))
  end

  it 'sets @collection' do
    expect(subject).to equal(object.instance_variable_get(:@collection))
  end
end
