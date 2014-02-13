require 'spec_helper'

describe Emulation, '#add_on_empty' do
  subject { object }

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
      error_collection,
      message_reporter,
      hash_reporter,
      array_reporter
    )
  end

  let(:base) { User.new(first_name: first_name) }
  let(:error_collection) { ErrorCollection.new(base) }
  let(:message_reporter) { double('message_reporter') }
  let(:hash_reporter) { double('hash_reporter') }
  let(:array_reporter) { double('array_reporter') }
  let(:options) { { message: message } }
  let(:message) { 'oops' }

  before do
    klass.send(:include, described_class)
  end

  context 'when attributes is a single attribute' do
    subject { error_collection[:first_name].first }

    before do
      object.add_on_empty(:first_name, options)
    end

    context 'when value responds to empty' do
      context 'and value is empty' do
        let(:first_name) { [] }

        its(:message) { should eql message }
        its(:type) { should eql :empty }
      end

      context 'and value is not empty' do
        let(:first_name) { ['foobar'] }

        it { should be_nil }
      end
    end

    context 'when value does not respond to empty' do
      context 'and value is nil' do
        let(:first_name) { nil }

        its(:message) { should eql message }
        its(:type) { should eql :empty }
      end

      context 'and value is false' do
        let(:first_name) { false }

        it { should be_nil }
      end

      context 'and value is not nil' do
        let(:first_name) { Object.new }

        it { should be_nil }
      end
    end
  end

  context 'when attributes is an array' do
    subject { error_collection.keys }
    let(:base) { User.new(first_name: [], last_name: []) }

    before do
      object.add_on_empty([:first_name, :last_name], options)
    end

    its(:size) { should eql 2 }
  end

  context 'with default options' do
    subject { error_collection[:first_name].first }

    let(:first_name) { [] }

    before do
      object.add_on_empty(:first_name)
    end

    its(:message) { should eql nil }
    its(:type) { should eql :empty }
  end
end
