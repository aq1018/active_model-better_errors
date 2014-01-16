# encoding: utf-8

require 'spec_helper'

describe ErrorMessage, '#<=>' do
  subject { e1 <=> e2 }

  let(:builder) { described_class::Builder }
  let(:base)    { User.new }

  context 'when attribute is different' do
    let(:e1) { builder.build base, :name, :invalid }
    let(:e2) { builder.build base, :name1, :invalid }
    it { should be_nil }
  end

  context 'when type is different' do
    let(:e1) { builder.build base, :name, :invalid }
    let(:e2) { builder.build base, :name, :invalid1 }
    it { should be_nil }
  end

  context 'when message is different' do
    let(:e1) { builder.build base, :name, :invalid, message: 'a' }
    let(:e2) { builder.build base, :name, :invalid, message: 'b' }
    it { should be_nil }
  end

  context 'when it is the same' do
    let(:e1) { builder.build base, :name, :invalid }
    let(:e2) { builder.build base, :name, :invalid }
    it { should == 0 }
  end
end
