# encoding: utf-8

require 'spec_helper'

describe Registry, '#types' do
  subject { object.types }

  let(:object)    { described_class.new }
  let(:klass)     { Class.new }
  let(:type)      { :foo }

  before { object.register(type, klass) }

  it { should eql [type] }
end
