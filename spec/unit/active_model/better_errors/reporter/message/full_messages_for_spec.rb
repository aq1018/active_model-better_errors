# encoding: utf-8

require 'spec_helper'

describe Reporter::Message, '#full_messages_for' do

  subject { object.full_messages_for(:first_name) }

  let(:object)          { described_class.new(collection, formatter_type) }
  let(:collection)      { ErrorCollection.new(base) }
  let(:formatter_type)  { :machine }
  let(:base)            { User.new }
  let(:expected)        do
    [{
      attribute: :first_name,
      message: :invalid,
      options: {}
    }, {
      attribute: :first_name,
      message: :too_long,
      options: {}
    }]
  end

  before do
    collection[:first_name] << :invalid << :too_long
    collection[:last_name]  << :invalid << :too_short
  end

  it { should eql expected }
end
