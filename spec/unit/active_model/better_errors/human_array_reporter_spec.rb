# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors::HumanArrayReporter do
  subject           { reporter }
  let(:reporter)    { klass.new collection }
  let(:klass)       { ActiveModel::BetterErrors::HumanArrayReporter }
  let(:collection)  { ActiveModel::BetterErrors::ErrorCollection.new base }
  let(:base)        { User.new }

  describe '#initialize' do
    its(:collection) { should be collection }
  end

  describe '#base' do
    its(:base) { should be base }
  end

  describe '#to_a' do
    subject { reporter.to_a }
    let(:expected) do
      %w(foo bar)
    end

    before do
      message_reporter = double
      ActiveModel::BetterErrors::HumanMessageReporter
        .should_receive(:new)
        .and_return(message_reporter)

      message_reporter
        .should_receive(:full_messages)
        .and_return(expected)
    end

    it { should == expected }
  end
end
