# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#each' do
  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:collection)  do
    {
      first_name: [:invalid, 'no good'],
      last_name: [:no_good, 'bad']
    }
  end

  let(:expected) do
    {
      first_name: [{
        attribute:  :first_name,
        type:       :invalid,
        message:    nil,
        options:    {}
      }, {
        attribute:  :first_name,
        type:       nil,
        message:    'no good',
        options:    {}
      }],
      last_name: [{
        attribute:  :last_name,
        type:       :no_good,
        message:    nil,
        options:    {}
      }, {
        attribute:  :last_name,
        type:       nil,
        message:    'bad',
        options:    {}
      }]
    }
  end

  before do
    collection.each do |(attribute, errors)|
      object.set attribute, errors
    end
  end

  it 'loops through all errors' do
    results = {}
    object.each do |attribute, error_message|
      results[attribute] ||= []
      results[attribute] << error_message.to_hash
    end

    expect(results).to eql(expected)
  end
end
