# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#to_a' do
  subject           { object.to_a }

  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:collection)  do
    {
      first_name: [:invalid, 'no good'],
      last_name: [:no_good, 'bad']
    }
  end

  let(:expected) { object[:first_name] + object[:last_name] }

  before do
    collection.each do |(attribute, errors)|
      object.set attribute, errors
    end
  end

  it { should eql(expected) }

end
