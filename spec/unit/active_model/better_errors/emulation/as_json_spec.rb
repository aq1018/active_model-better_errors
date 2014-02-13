# encoding: utf-8

require 'spec_helper'

describe Emulation, '#as_json' do
  include Helper

  subject { object.as_json }

  let(:klass) do
    Struct.new(
      :base,
      :error_collection,
      :message_reporter,
      :hash_reporter,
      :array_reporter
    )
  end

  let(:object) do
    klass.new(
      base,
      collection,
      message_reporter,
      hash_reporter,
      array_reporter
    )
  end

  before { klass.send :include, described_class }

  let(:base) { User.new }
  let(:collection) { ErrorCollection.new(base) }
  let(:message_reporter) { reporters.build(:message, collection, :human) }
  let(:hash_reporter) { reporters.build(:hash, collection, :machine) }
  let(:array_reporter) { reporters.build(:array, collection, :machine) }

  context 'without options' do
    subject { object.as_json({}) }

    let(:expected) do
      {
        first_name: [{
          message: :invalid,
          options: {}
        }],
      }
    end

    before { object.add(:first_name) }

    it { should eql expected }
  end

  context 'with empty options' do
    let(:expected) do
      {
        first_name: [{
          message: :invalid,
          options: {}
        }],
      }
    end

    before { object.add(:first_name) }

    it { should eql expected }
  end

  context 'with :full_message option' do
    subject { object.as_json(full_messages: true) }

    let(:expected) do
      {
        first_name: [{
          attribute: :first_name,
          message: :invalid,
          options: {}
        }]
      }
    end

    before { object.add(:first_name) }

    it { should eql expected }
  end
end
