# encoding: utf-8

require 'spec_helper'

describe Registry, '#build' do

  # :nodoc:
  class Foo
    attr_reader :foo, :bar

    def initialize(foo, bar)
      @foo = foo
      @bar = bar
    end
  end

  subject { object.build(type, 'foo', 'bar') }

  let(:object)    { described_class.new }
  let(:klass)     { Foo }
  let(:type)      { :foo }

  before { object.register(type, klass) }

  it { should be_a klass }
  its(:foo) { should eql 'foo' }
  its(:bar) { should eql 'bar' }
end
