# encoding: utf-8

require 'spec_helper'

describe ActiveModel::ErrorCollecting::Errors do
  subject(:instance) { klass.new base }
  let(:klass) { ActiveModel::ErrorCollecting::Errors }
  let(:base)  { User.new }
  let(:reporter_name) { :mock }
  let(:mock_reporter) do
    Class.new do
      def initialize(collection)
      end
    end
  end

  describe '#initialize' do
    its(:base) { should be base }
  end

  describe '#error_collection' do
    subject { instance.error_collection }
    it { should be_a ActiveModel::ErrorCollecting::ErrorCollection }
    its(:base) { should be base }
  end

  describe '#message_reporter' do
    subject { instance.message_reporter }
    let(:mock_reporter) { mock }
    before do
      instance.
        should_receive(:get_reporter).
        with(:message).
        and_return(mock_reporter)
    end

    it { should be mock_reporter }
  end

  describe '#hash_reporter' do
    subject { instance.hash_reporter }
    let(:mock_reporter) { mock }
    before do
      instance.
        should_receive(:get_reporter).
        with(:hash).
        and_return(mock_reporter)
    end

    it { should be mock_reporter }
  end

  describe '#array_reporter' do
    subject { instance.array_reporter }
    let(:mock_reporter) { mock }
    before do
      instance.
        should_receive(:get_reporter).
        with(:array).
        and_return(mock_reporter)
    end

    it { should be mock_reporter }
  end

  describe '#set_reporter' do
    it 'should set the reporter class' do
      instance.set_reporter reporter_name, mock_reporter
      reporter_classes = instance.instance_variable_get(:@reporter_classes)
      reporter_classes[reporter_name.to_s].should == mock_reporter
    end

    it 'should delete old reporter instance' do
      reporters = instance.instance_variable_get(:@reporters)
      reporters[reporter_name] = mock
      instance.set_reporter reporter_name, mock_reporter
      reporters.key?(reporter_name.to_s).should be false
    end
  end

  describe '#get_reporter_class' do
    subject { instance.get_reporter_class(reporter_name) }
    before { instance.set_reporter reporter_name, mock_reporter }
    it { should == mock_reporter }
  end

  describe '#get_reporter' do
    subject { instance.get_reporter(reporter_name) }
    before { instance.set_reporter reporter_name, mock_reporter }
    it { should be_a mock_reporter }
  end

  describe '#reporter_classes' do
    subject { instance.reporter_classes }
    it { should == ::ActiveModel::ErrorCollecting.reporters }
  end
end
