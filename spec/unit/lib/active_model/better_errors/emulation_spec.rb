# encoding: utf-8

require 'spec_helper'

shared_examples_for 'a delegated method' do
  let(:target_instance) { double }
  before do
    target_instance.should_receive method
    instance.stub(target).and_return(target_instance)
  end

  specify { instance.send method }
end

describe ActiveModel::BetterErrors::Emulation do
  subject(:instance) { klass.new }
  let(:klass) { Class.new { include ActiveModel::BetterErrors::Emulation } }

  delegation_map = {
    error_collection: [
      :clear, :include?, :get, :set, :delete, :[], :[]=, :each, :size,
      :values, :keys, :count, :empty?, :added?, :any?, :entries
    ],

    message_reporter: [
      :full_messages, :full_message, :generate_message
    ],

    hash_reporter: [
      :to_hash
    ],

    hash_reporter: [
      :to_hash
    ]
  }

  delegation_map.each do |target, methods|
    methods.each do |method|
      describe "delegating ##{method} to  ##{target}" do
        let(:target) { target }
        let(:method) { method }
        it_should_behave_like 'a delegated method'
      end
    end
  end
end
