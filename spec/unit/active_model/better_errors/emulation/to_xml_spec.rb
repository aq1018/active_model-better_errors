# encoding: utf-8

require 'spec_helper'

describe Emulation, '#to_xml' do
  include Helper

  subject { object.to_xml }

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

  context 'with default options' do
    let(:expected) do
      <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<errors>
  <error>
    <attribute>first_name</attribute>
    <message>invalid</message>
    <options>
    </options>
  </error>
</errors>
      XML
    end

    before { object.add(:first_name) }

    it { should eql expected }
  end

  context 'with non-default options' do
    subject { object.to_xml(root: 'better_errors') }

    let(:expected) do
      <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<better-errors>
  <better-error>
    <attribute>first_name</attribute>
    <message>invalid</message>
    <options>
    </options>
  </better-error>
</better-errors>
      XML
    end

    before { object.add(:first_name) }

    it { should eql expected }
  end
end
