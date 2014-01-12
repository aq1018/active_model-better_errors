# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors::MachineArrayReporter do
  subject           { reporter }
  let(:reporter)    { klass.new collection }
  let(:klass)       { ActiveModel::BetterErrors::MachineArrayReporter }
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

    before  do
      collection[:first_name] << :invalid
      collection[:first_name] << [:too_short, { count: 3 }]
      collection[:last_name] << :invalid
    end

    let(:expected) do
      [{
        attribute: 'first_name',
        type:      :invalid
      }, {
        attribute: 'first_name',
        type:      :too_short,
        options:   { count: 3 }
      }, {
        attribute: 'last_name',
        type:      :invalid
      }]
    end

    it { should == expected }
  end
end
