# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors do
  describe '.set_reporter' do
    subject { ActiveModel::BetterErrors.reporters[name.to_s] }
    before { ActiveModel::BetterErrors.set_reporter name, reporter }
    after  { ActiveModel::BetterErrors.set_reporter name, nil }
    let(:name) { :mock }
    let(:reporter) { Class.new }
    it { should be reporter }
  end

  describe '.reporters' do
    subject { ActiveModel::BetterErrors.reporters }
    let(:expected) do
      {
        'message' => ActiveModel::BetterErrors::HumanMessageReporter,
        'array'   => ActiveModel::BetterErrors::HumanArrayReporter,
        'hash'    => ActiveModel::BetterErrors::HumanHashReporter
      }
    end
    it { should == expected }
  end

  describe '.formatter' do
    subject { ActiveModel::BetterErrors.formatter }
    it { should == ActiveModel::BetterErrors::HumanMessageFormatter }
  end
end

describe 'ActiveModel Better Errors' do
  it 'overrides ActiveModel Validations' do
    User.new.errors.should be_a ActiveModel::BetterErrors::Errors
  end
end
