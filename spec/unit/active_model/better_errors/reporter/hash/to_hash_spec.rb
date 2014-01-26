# encoding: utf-8

require 'spec_helper'

describe Reporter::Hash, '#to_hash' do

  subject { object.to_hash }

  let(:object)          { described_class.new(collection, formatter_type) }
  let(:collection)      { ErrorCollection.new(base) }
  let(:formatter_type)  { :machine }
  let(:base)            { User.new }
  let(:expected)        do
    {
      first_name: [{
        message: :invalid,
        options: {}
      }, {
        message: :too_long,
        options: {}
      }],
      last_name: [{
        message: :invalid,
        options: {}
      }, {
        message: :too_short,
        options: {}
      }]
    }
  end

  before do
    collection[:first_name] << :invalid << :too_long
    collection[:last_name]  << :invalid << :too_short
  end

  it { should eql expected }
end
