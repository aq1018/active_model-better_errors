# encoding: utf-8

require 'spec_helper'

describe Registry, '#[]' do
  subject         { object[type] }

  let(:object)    { described_class.new }
  let(:klass)     { Class.new }
  let(:type)      { :foo }

  context 'when class is not registerd' do
    it 'raises error' do
      expect { subject }.to raise_error
    end
  end

  context 'when class is registered' do
    before { object.register(type, klass) }

    it { should eql klass }
  end

end
