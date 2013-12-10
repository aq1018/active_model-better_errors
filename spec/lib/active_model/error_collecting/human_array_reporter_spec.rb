# encoding: utf-8

require 'spec_helper'

describe ActiveModel::ErrorCollecting::HumanArrayReporter do
  subject(:reporter)  { klass.new collection }
  let(:klass)         { ActiveModel::ErrorCollecting::HumanArrayReporter }
  let(:collection)    { ActiveModel::ErrorCollecting::ErrorCollection.new base }
  let(:base)          { User.new }

  describe '#initialize' do
    its(:collection) { should be collection }
  end

  describe '#base' do
    its(:base) { should be base }
  end

  describe '#to_a' do
    subject { reporter.to_a }
    let(:expected) { ['foo', 'bar'] }
    before do
      message_reporter = mock
      ActiveModel::ErrorCollecting::HumanMessageReporter.
        should_receive(:new).
        and_return(message_reporter)

      message_reporter.
        should_receive(:full_messages).
        and_return(expected)
    end

    it { should == expected }
  end
end
