# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#to_hash' do
  subject           { object.to_hash }

  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:collection)  do
    {
      first_name: [:invalid, 'no good'],
      last_name: [:no_good, 'bad']
    }
  end

  let(:expected) { object.send :collection }

  before do
    collection.each do |(attribute, errors)|
      object.set attribute, errors
    end
  end

  it { should eql(expected) }
  it { should_not equal(expected) }
end
