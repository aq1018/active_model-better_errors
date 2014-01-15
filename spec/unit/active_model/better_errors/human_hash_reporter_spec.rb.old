# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors::HumanHashReporter do
  subject { reporter }
  let(:reporter)    { klass.new collection }
  let(:klass)       { ActiveModel::BetterErrors::HumanHashReporter }
  let(:collection)  { ActiveModel::BetterErrors::ErrorCollection.new base }
  let(:base)        { User.new }

  describe '#initialize' do
    its(:collection) { should be collection }
  end

  describe '#base' do
    its(:base) { should be base }
  end

  describe '#to_hash' do
    subject { reporter.to_hash }
    let(:expected) do
      {
        first_name: ['is invalid', "can't be empty"],
        last_name: ['is invalid']
      }
    end

    before  do
      collection[:first_name] << :invalid
      collection[:first_name] << :empty
      collection[:last_name] << :invalid
    end

    it { should == expected }
  end
end
