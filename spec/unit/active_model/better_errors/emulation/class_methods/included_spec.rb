# encoding: utf-8

require 'spec_helper'

describe Emulation, '.included' do
  subject { object }

  let(:klass) do
    Struct.new(
      :error_collection,
      :message_reporter,
      :hash_reporter,
      :array_reporter
    )
  end

  let(:object) do
    klass.new(
      error_collection,
      message_reporter,
      hash_reporter,
      array_reporter
    )
  end

  let(:error_collection) { double('error_collection') }
  let(:message_reporter) { double('message_reporter') }
  let(:hash_reporter) { double('hash_reporter') }
  let(:array_reporter) { double('array_reporter') }

  before do
    klass.send(:include, described_class)
  end

  [
    :clear, :include?, :get, :set, :delete, :[], :[]=,
    :each, :size, :values, :keys, :count, :empty?, :any?,
    :added?, :entries
  ].each do |method|
    it "delegates ##{method} to error_collection" do
      error_collection.should_receive(method)
      object.send(method)
    end
  end

  [
    :full_messages, :full_messages_for,
    :full_message, :generate_message
  ].each do |method|
    it "delegates ##{method} to message_reporter" do
      message_reporter.should_receive(method)
      object.send(method)
    end
  end

  it 'delegates #to_hash to hash_reporter' do
    hash_reporter.should_receive(:to_hash)
    object.send(:to_hash)
  end

  it 'delegates #to_a to array_reporter' do
    array_reporter.should_receive(:to_a)
    object.send(:to_a)
  end

  it 'aliases #has_key? to #include?' do
    error_collection.should_receive(:include?)
    object.send(:has_key?)
  end
end
