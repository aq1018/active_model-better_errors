# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors::ErrorMessage::Builder do
  let(:builder)   { described_class.new(base, attribute, message, options) }
  let(:attribute) { :name }
  let(:base)      { User.new }
  let(:message)   { :invalid }
  let(:options)   { {} }

  describe '#initialize' do
    subject       { builder }
    let(:options) { { foo: :bar } }

    its(:base)      { should be base }
    its(:attribute) { should be attribute }
    its(:message)   { should be message }
    its(:options)   { should be options }
  end

  describe '#override' do
    subject         { builder.override }
    let(:options)   { { message: override } }
    let(:override)  { :foo }

    it { should be override }

    it 'deletes options[:message]' do
      subject
      expect(builder.options).to_not include(:message)
    end

    it 'memoizes' do
      o1 = builder.override
      o2 = builder.override
      expect(o2).to be(o1)
    end
  end

  describe '#normalized_message' do
    subject         { builder.normalized_message }
    let(:expected)  { 'foo' }

    before do
      builder.class.should_receive(:normalize)
        .with(message).and_return(expected)
    end

    it { should == expected }

    it 'memoizes' do
      v1 = builder.normalized_message
      v2 = builder.normalized_message
      expect(v2).to be(v1)
    end
  end

  describe '#normalized_override' do
    subject         { builder.normalized_override }
    let(:expected)  { 'foo' }

    before do
      builder.class.should_receive(:normalize)
        .with(message).and_return(expected)
    end

    it { should == expected }

    it 'memoizes' do
      v1 = builder.normalized_message
      v2 = builder.normalized_message
      expect(v2).to be(v1)
    end
  end

  # describe '.normalize' do
  #   subject { klass.normalize message }
  #   context 'when message is a symbol' do
  #     let(:message) { :invalid }

  #     it { should == message }
  #   end

  #   context 'when message is nil' do
  #     let(:message) { nil }
  #     it { should be nil }
  #   end

  #   context 'when message is a string' do
  #     let(:message) { 'bad' }
  #     it { should == message }
  #   end

  #   context 'when message is a proc' do
  #     let(:message) { proc { 'bad' } }
  #     it { should == 'bad' }
  #   end

  #   context 'when message has #to_s method' do
  #     let(:message) { double() }
  #     before { message.should_receive(:to_s).and_return('bad') }
  #     it { should == 'bad' }
  #   end
  # end

  # describe '.identify' do
  #   subject { klass.identify message, override }
  #   context 'when message is a symbol and' do
  #     let(:message) { :invalid }

  #     context 'when override is a symbol' do
  #       let(:override) { :not_good }
  #       it { should == [:not_good, nil] }
  #     end

  #     context 'when override is nil' do
  #       let(:override) { nil }
  #       it { should == [:invalid, nil] }
  #     end

  #     context 'when override is ""' do
  #       let(:override) { "" }
  #       it { should == [:invalid, nil] }
  #     end

  #     context 'when override is a string' do
  #       let(:override) { 'invalid' }
  #       it { should == [:invalid, 'invalid'] }
  #     end

  #     context 'when override is a proc' do
  #       let(:override) { proc { 'Not good' } }
  #       it { should == [:invalid, 'Not good'] }
  #     end
  #   end

  #   context 'when message is a string and' do
  #     let(:message) { 'Invalid' }

  #     context 'when override is a symbol' do
  #       let(:override) { :not_good }
  #       it { should == [:not_good, 'Invalid'] }
  #     end

  #     context 'when override is nil' do
  #       let(:override) { nil }
  #       it { should == [nil, 'Invalid'] }
  #     end

  #     context 'when override is a string' do
  #       let(:override) { 'not good' }
  #       it { should == [nil, 'not good'] }
  #     end

  #     context 'when override is a proc' do
  #       let(:override) { proc { 'Not Good' } }
  #       it { should == [nil, 'Not Good'] }
  #     end
  #   end

  #   context 'when message is nil and' do
  #     let(:message) { nil }

  #     context 'when override is a symbol' do
  #       let(:override) { :not_good }
  #       it { should == [:not_good, nil] }
  #     end

  #     context 'when override is nil' do
  #       let(:override) { nil }
  #       it { should == [nil, nil] }
  #     end

  #     context 'when override is a string' do
  #       let(:override) { 'not good' }
  #       it { should == [nil, 'not good'] }
  #     end

  #     context 'when override is a proc' do
  #       let(:override) { proc { 'Not Good' } }
  #       it { should == [nil, 'Not Good'] }
  #     end
  #   end

  #   context 'when message is a proc and' do
  #     let(:message) { proc { 'invalid' } }

  #     context 'when override is a symbol' do
  #       let(:override) { :not_good }
  #       it { should == [:not_good, 'invalid'] }
  #     end

  #     context 'when override is nil' do
  #       let(:override) { nil }
  #       it { should == [nil, 'invalid'] }
  #     end

  #     context 'when override is a string' do
  #       let(:override) { 'not good' }
  #       it { should == [nil, 'not good'] }
  #     end

  #     context 'when override is a proc' do
  #       let(:override) { proc { 'Not Good' } }
  #       it { should == [nil, 'Not Good'] }
  #     end
  #   end
  # end

  # describe '.build' do
  #   context 'when message is a symbol and' do
  #     let(:message) { :invalid }

  #     context 'when options[:message] is a string' do
  #       let(:options) { { message: 'Not Really Valid!' } }
  #       its(:type)    { should == message }
  #       its(:message) { should == options[:message] }
  #     end

  #     context 'when options[:message] is a symbol' do
  #       let(:options) { { message: :not_really_valid } }
  #       its(:type)    { should == options[:message] }
  #       its(:message) { should be_nil }
  #     end

  #     context 'when options[:message] is nil' do
  #       let(:options) { { message: nil } }
  #       its(:type)    { should == message }
  #       its(:message) { should be_nil }
  #     end

  #     context 'when options[:message] is proc' do
  #       let(:options) { { message: proc { 'Not Really Valid!' } } }
  #       its(:type)    { should == message }
  #       its(:message) { should == options[:message].call }
  #     end
  #   end

  #   context 'when message is a string and' do
  #     let(:message) { 'Invalid!' }

  #     context 'when options[:message] is a string' do
  #       let(:options) { { message: 'Not Really Valid!' } }
  #       its(:type)    { should be_nil }
  #       its(:message) { should == options[:message] }
  #     end

  #     context 'when options[:message] is a symbol' do
  #       let(:options) { { message: :not_really_valid } }
  #       its(:type)    { should == options[:message] }
  #       its(:message) { should == message }
  #     end

  #     context 'when options[:message] is nil' do
  #       let(:options) { {} }
  #       its(:type)    { should be_nil }
  #       its(:message) { should == message }
  #     end

  #     context 'when options[:message] is proc' do
  #       let(:options) { { message: proc { 'Not Really Valid!' } } }
  #       its(:type)    { should be_nil }
  #       its(:message) { should == options[:message].call }
  #     end
  #   end

  #   context 'when message is a proc and' do
  #     let(:message) { proc { 'Invalid!' } }

  #     context 'when options[:message] is a string' do
  #       let(:options) { { message: 'Not Really Valid!' } }
  #       its(:type)    { should be_nil }
  #       its(:message) { should == options[:message] }
  #     end

  #     context 'when options[:message] is a symbol' do
  #       let(:options) { { message: :not_really_valid } }
  #       its(:type)    { should == options[:message] }
  #       its(:message) { should == message.call }
  #     end

  #     context 'when options[:message] is nil' do
  #       let(:options) { {} }
  #       its(:type)    { should be_nil }
  #       its(:message) { should == message.call }
  #     end

  #     context 'when options[:message] is proc' do
  #       let(:options) { { message: proc { 'Not Really Valid!' } } }
  #       its(:type)    { should be_nil }
  #       its(:message) { should == options[:message].call }
  #     end
  #   end

  #   context 'when message is nil and' do
  #     let(:message) { nil }

  #     context 'when options[:message] is a string' do
  #       let(:options) { { message: 'Not Really Valid!' } }
  #       its(:type)    { should be_nil }
  #       its(:message) { should == options[:message] }
  #     end

  #     context 'when options[:message] is a symbol' do
  #       let(:options) { { message: :not_really_valid } }
  #       its(:type)    { should == options[:message] }
  #       its(:message) { should be_nil }
  #     end

  #     context 'when options[:message] is nil' do
  #       let(:options) { {} }
  #       its(:type)    { should be_nil }
  #       its(:message) { should be_nil }
  #     end

  #     context 'when options[:message] is proc' do
  #       let(:options) { { message: proc { 'Not Really Valid!' } } }
  #       its(:type)    { should be_nil }
  #       its(:message) { should == options[:message].call }
  #     end
  #   end

  #   [
  #     :if, :unless, :on, :allow_nil, :allow_blank, :strict, :message
  #   ].each do |field|
  #     context "when options includes :#{field}" do
  #       let(:message) { :invalid }
  #       let(:options) { {} }
  #       before { options[field] = proc {} }
  #       its(:options) { should == {} }
  #     end
  #   end
  # end
end
