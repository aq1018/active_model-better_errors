require 'spec_helper'

describe ActiveModel::ErrorCollecting::ErrorMessage do
  let(:klass)     { ActiveModel::ErrorCollecting::ErrorMessage }
  let(:attribute) { :name }
  subject(:error_message) { klass.build(attribute, message, options) }

  describe ".build" do

    context "when message is a symbol and" do
      let(:message) { :invalid }

      context "when options[:message] is a string" do
        let(:options) { { message: "Not Really Valid!" } }
        its(:key)     { should == message }
        its(:message) { should == options[:message] }
      end

      context "when options[:message] is a symbol" do
        let(:options) { { message: :not_really_valid } }
        its(:key)     { should == options[:message] }
        its(:message) { should == nil }
      end

      context "when options[:message] is nil" do
        let(:options) { { message: nil } }
        its(:key)     { should == message }
        its(:message) { should == nil }
      end
    end

    context "when message is a string and" do
      let(:message) { 'Invalid!' }

      context "when options[:message] is a string" do
        let(:options) { { message: "Not Really Valid!" } }
        its(:key)     { should == nil }
        its(:message) { should == options[:message] }
      end

      context "when options[:message] is a symbol" do
        let(:options) { { message: :not_really_valid } }
        its(:key)     { should == options[:message] }
        its(:message) { should == message }
      end

      context "when options[:message] is nil" do
        let(:options) { { } }
        its(:key)     { should == nil }
        its(:message) { should == message }
      end
    end

    context "when message is nil" do
      let(:message) { nil }
      let(:options) { {} }
      specify do
        expect{ error_message }.to raise_error ArgumentError
      end
    end
  end

  describe '#initialize' do
    let(:message) { :invalid }
    let(:options) { { message: "Invalid!", count: 12 } }

    its(:options)   { should == { count: 12 } }
    its(:attribute) { should == attribute }
  end

  describe '#<=>' do
    subject { e1 <=> e2 }

    context "when attribute is different" do
      let(:e1) { klass.build :name, :invalid }
      let(:e2) { klass.build :name1, :invalid }
      it {should == nil }
    end

    context "when key is different" do
      let(:e1) { klass.build :name, :invalid }
      let(:e2) { klass.build :name, :invalid1 }
      it {should == nil }
    end

    context "when message is different" do
      let(:e1) { klass.build :name, :invalid, :message => "a" }
      let(:e2) { klass.build :name, :invalid, :message => "b" }
      it {should == nil }
    end

    context "when it is the same" do
      let(:e1) { klass.build :name, :invalid }
      let(:e2) { klass.build :name, :invalid }
      it { should == 0 }
    end

  end
end