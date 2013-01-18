require 'spec_helper'

describe ActiveModel::ErrorCollecting::ErrorMessageSet do
  subject(:set)   { klass.new attribute, errors }
  let(:klass)     { ActiveModel::ErrorCollecting::ErrorMessageSet }
  let(:attribute) { :name }
  let(:errors)    { [] }


  describe "#initialize" do
    context "with no errors" do
      its(:length) { should == 0 }
    end

    context "with one error" do
      let(:errors)    { [:invalid] }
      its(:length) { should == 1 }
    end
  end

  describe "#add" do
    subject { set.add error, options }
    let(:error)  { :invalid }
    let(:options)   { nil }

    describe "without options" do
      it { should be_a ActiveModel::ErrorCollecting::ErrorMessage }
      its(:message)   { should == nil }
      its(:key)       { should == error }
    end

    describe "with options" do
      let(:options)   { { message: 'Invalid' } }

      it { should be_a ActiveModel::ErrorCollecting::ErrorMessage }
      its(:message)   { should == options[:message] }
      its(:key)       { should == error }
    end

    it "does not store duplicates" do
      set.add error, options
      set.add error, options

      set.length.should == 1
    end
  end

  describe "#<<" do
    subject { set << error }

    describe "when accepting error as a symbol" do
      let(:error)  { :invalid }

      it { should be_a ActiveModel::ErrorCollecting::ErrorMessage }
      its(:message)   { should == nil }
      its(:key)       { should == error }
    end

    describe "when accepting error as a tuple" do
      let(:error)  { [ :invalid, { message: "OMG!!" } ]}

      it { should be_a ActiveModel::ErrorCollecting::ErrorMessage }
      its(:message)   { should == "OMG!!" }
      its(:key)       { should == :invalid }
    end
  end

  describe "#to_a" do
    let(:errors) { [:invalid, :too_long] }
    subject { set.to_a }

    it { should be_a Array }
    its(:length) { should == 2 }
  end

  describe "#empty?" do
    subject { set.empty? }

    describe "when no error messages" do
      it { should be_true }
    end

    describe "when contains error messages" do
      let(:errors) { [:invalid, :too_long] }
      it { should be_false }
    end
  end

  describe "#==" do
    subject { set == errors }
    let(:errors) { [:invalid, :too_long] }
    describe "When comparing with array" do
      it { should be true }
    end
  end
end
