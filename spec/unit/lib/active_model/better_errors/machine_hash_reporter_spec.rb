# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors::MachineHashReporter do
  subject           { reporter }
  let(:reporter)    { klass.new collection }
  let(:klass)       { ActiveModel::BetterErrors::MachineHashReporter }
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

    before  do
      collection[:first_name] << :invalid
      collection[:first_name] << [:too_short, { count: 3 }]
      collection[:last_name] << :invalid
    end

    let(:expected) do
      {
        first_name: [{
          type:      :invalid
        }, {
          type:      :too_short,
          options:   { count: 3 }
        }],
        last_name: [{
          type:      :invalid
        }]
      }
    end

    it { should == expected }
  end
end
