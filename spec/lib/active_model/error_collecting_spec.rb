# encoding: utf-8

require 'spec_helper'

describe ActiveModel::ErrorCollecting do
  describe '.set_reporter' do
    subject { ActiveModel::ErrorCollecting.reporters[name.to_s] }
    before { ActiveModel::ErrorCollecting.set_reporter name, reporter }
    after  { ActiveModel::ErrorCollecting.set_reporter name, nil }
    let(:name) { :mock }
    let(:reporter) { Class.new }
    it { should be reporter }
  end

  describe '.reporters' do
    subject { ActiveModel::ErrorCollecting.reporters }
    let(:expected) do
      {
        'message' => ActiveModel::ErrorCollecting::HumanMessageReporter,
        'array'   => ActiveModel::ErrorCollecting::HumanArrayReporter,
        'hash'    => ActiveModel::ErrorCollecting::HumanHashReporter
      }
    end
    it { should == expected }
  end
end
