# encoding: utf-8

require 'spec_helper'

describe Registry, '#register' do
  subject         { object.register(type, klass) }

  let(:object)    { described_class.new }
  let(:klass)     { Class.new }
  let(:type)      { :foo }

  it { should eql object }

  it 'registers class' do
    expect(subject[type]).to equal klass
  end
end
