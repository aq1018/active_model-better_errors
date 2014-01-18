# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#size' do
  subject           { object.size }

  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:collection)  do
    {
      first_name: [:invalid, 'no good'],
      last_name: [:no_good]
    }
  end

  before do
    collection.each do |(attribute, errors)|
      object.set attribute, errors
    end
  end

  it { should eql 3 }
end
