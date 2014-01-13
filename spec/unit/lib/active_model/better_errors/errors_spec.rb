# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors::Errors do
  subject(:instance) { klass.new base }
  let(:klass) { ActiveModel::BetterErrors::Errors }
  let(:base)  { User.new }
  let(:reporter_name) { :array }
  let(:mock_reporter) do
    Class.new(ActiveModel::BetterErrors::Reporter::Array) do
      def to_a
        [:mock]
      end
    end
  end

  before do
    ActiveModel::BetterErrors.reporters.register(reporter_name, mock_reporter)
  end

  after do
    ActiveModel::BetterErrors.reporters.register(
      reporter_name, ActiveModel::BetterErrors::Reporter::Array
    )
  end

  describe '#initialize' do
    its(:base) { should be base }
    its(:formatter_type) { should == instance.send(:default_formatter_type) }
  end

  describe '#format' do
    before { instance.format(:test) }
    its(:formatter_type) { should == :test }
  end

  describe '#error_collection' do
    subject { instance.send :error_collection }
    it { should be_a ActiveModel::BetterErrors::ErrorCollection }
    its(:base) { should be base }
  end

  describe '#reporter_for' do
    subject { instance.send :reporter_for, reporter_name }
    it { should be_a mock_reporter }
  end

  describe '#message_reporter' do
    subject { instance.message_reporter }
    before do
      instance
        .should_receive(:reporter_for)
        .with(:message)
        .and_return(mock_reporter)
    end

    it { should be mock_reporter }
  end

  describe '#hash_reporter' do
    subject { instance.hash_reporter }
    before do
      instance
        .should_receive(:reporter_for)
        .with(:hash)
        .and_return(mock_reporter)
    end

    it { should be mock_reporter }
  end

  describe '#array_reporter' do
    subject { instance.array_reporter }
    before do
      instance
        .should_receive(:reporter_for)
        .with(:array)
        .and_return(mock_reporter)
    end

    it { should be mock_reporter }
  end
end
