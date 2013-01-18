require 'spec_helper'

describe ActiveModel::ErrorCollecting::ErrorMessage do
  let(:klass)     { ActiveModel::ErrorCollecting::ErrorMessage }
  let(:attribute) { :name }
  subject(:error_message) { klass.build(attribute, message, options) }

  describe ".normalize" do
    subject { klass.normalize message }
    context "when message is a symbol" do
      let(:message) { :invalid }
      it { should == message }
    end

    context "when message is nil" do
      let(:message) { nil }
      it { should be nil }
    end

    context "when message is a string" do
      let(:message) { 'bad' }
      it { should == message }
    end

    context "when message is a proc" do
      let(:message) { proc { 'bad' } }
      it { should == 'bad' }
    end
  end

  describe ".identify" do
    subject { klass.identify message, override }
    context "when message is a symbol and" do
      let(:message) { :invalid }

      context "when override is a symbol" do
        let(:override) { :not_good }
        it { should == [:not_good, nil] }
      end

      context "when override is nil" do
        let(:override) { nil }
        it { should == [:invalid, nil] }
      end

      context "when override is a string" do
        let(:override) { "invalid" }
        it { should == [:invalid, "invalid"] }
      end

      context "when override is a proc" do
        let(:override) { proc { "Not good" } }
        it { should == [:invalid, "Not good"] }
      end
    end

    context "when message is a string and" do
      let(:message) { "Invalid" }

      context "when override is a symbol" do
        let(:override) { :not_good }
        it { should == [:not_good, "Invalid"] }
      end

      context "when override is nil" do
        let(:override) { nil }
        it { should == [:invalid, "Invalid"] }
      end

      context "when override is a string" do
        let(:override) { "not good" }
        it { should == [:invalid, "not good"] }
      end

      context "when override is a proc" do
        let(:override) { proc { "Not Good" } }
        it { should == [:invalid, "Not Good"] }
      end
    end

    context "when message is nil and" do
      let(:message) { nil }

      context "when override is a symbol" do
        let(:override) { :not_good }
        it { should == [:not_good, nil] }
      end

      context "when override is nil" do
        let(:override) { nil }
        it { should == [:invalid, nil] }
      end

      context "when override is a string" do
        let(:override) { "not good" }
        it { should == [:invalid, "not good"] }
      end

      context "when override is a proc" do
        let(:override) { proc { "Not Good" } }
        it { should == [:invalid, "Not Good"] }
      end
    end

    context "when message is a proc and" do
      let(:message) { proc {"invalid"} }

      context "when override is a symbol" do
        let(:override) { :not_good }
        it { should == [:not_good, "invalid"] }
      end

      context "when override is nil" do
        let(:override) { nil }
        it { should == [:invalid, "invalid"] }
      end

      context "when override is a string" do
        let(:override) { "not good" }
        it { should == [:invalid, "not good"] }
      end

      context "when override is a proc" do
        let(:override) { proc { "Not Good" } }
        it { should == [:invalid, "Not Good"] }
      end
    end
  end


  describe ".build" do
    context "when message is a symbol and" do
      let(:message) { :invalid }

      context "when options[:message] is a string" do
        let(:options) { { message: "Not Really Valid!" } }
        its(:type)    { should == message }
        its(:message) { should == options[:message] }
      end

      context "when options[:message] is a symbol" do
        let(:options) { { message: :not_really_valid } }
        its(:type)    { should == options[:message] }
        its(:message) { should == nil }
      end

      context "when options[:message] is nil" do
        let(:options) { { message: nil } }
        its(:type)    { should == message }
        its(:message) { should == nil }
      end

      context "when options[:message] is proc" do
        let(:options) { { message: proc { "Not Really Valid!" } } }
        its(:type)    { should == message }
        its(:message) { should == options[:message].call }
      end
    end

    context "when message is a string and" do
      let(:message) { 'Invalid!' }

      context "when options[:message] is a string" do
        let(:options) { { message: "Not Really Valid!" } }
        its(:type)    { should == :invalid }
        its(:message) { should == options[:message] }
      end

      context "when options[:message] is a symbol" do
        let(:options) { { message: :not_really_valid } }
        its(:type)    { should == options[:message] }
        its(:message) { should == message }
      end

      context "when options[:message] is nil" do
        let(:options) { { } }
        its(:type)    { should == :invalid }
        its(:message) { should == message }
      end

      context "when options[:message] is proc" do
        let(:options) { { message: proc { "Not Really Valid!" } } }
        its(:type)    { should == :invalid }
        its(:message) { should == options[:message].call }
      end
    end

    context "when message is a proc and" do
      let(:message) { proc{ 'Invalid!' } }

      context "when options[:message] is a string" do
        let(:options) { { message: "Not Really Valid!" } }
        its(:type)    { should == :invalid }
        its(:message) { should == options[:message] }
      end

      context "when options[:message] is a symbol" do
        let(:options) { { message: :not_really_valid } }
        its(:type)    { should == options[:message] }
        its(:message) { should == message.call }
      end

      context "when options[:message] is nil" do
        let(:options) { { } }
        its(:type)    { should == :invalid }
        its(:message) { should == message.call }
      end

      context "when options[:message] is proc" do
        let(:options) { { message: proc { "Not Really Valid!" } } }
        its(:type)    { should == :invalid }
        its(:message) { should == options[:message].call }
      end
    end


    context "when message is nil and" do
      let(:message) { nil }

      context "when options[:message] is a string" do
        let(:options) { { message: "Not Really Valid!" } }
        its(:type)    { should == :invalid }
        its(:message) { should == options[:message] }
      end

      context "when options[:message] is a symbol" do
        let(:options) { { message: :not_really_valid } }
        its(:type)    { should == options[:message] }
        its(:message) { should == nil }
      end

      context "when options[:message] is nil" do
        let(:options) { { } }
        its(:type)    { should == :invalid }
        its(:message) { should == nil }
      end

      context "when options[:message] is proc" do
        let(:options) { { message: proc { "Not Really Valid!" } } }
        its(:type)    { should == :invalid }
        its(:message) { should == options[:message].call }
      end
    end

    [
      :if, :unless, :on, :allow_nil, :allow_blank, :strict, :message
    ].each do |field|
      context "when options includes :#{field}" do
        let(:message) { :invalid }
        let(:options) { {} }
        before { options[field] = proc{} }
        its(:options) { should == {} }
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

    context "when type is different" do
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