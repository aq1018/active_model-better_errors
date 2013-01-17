require 'spec_helper'

describe ActiveModel::ErrorCollecting::HumanMessageFormatter do
  subject(:formatter) { klass.new base, }
  let(:klass) { ActiveModel::ErrorCollecting::HumanMessageFormatter }

  delegation_map = {
    error_collection: [
      :clear, :include?, :get, :set, :delete, :[], :[]=, :each, :size,
      :values, :keys, :count, :empty?, :added?, :add
    ],

    human_reporter: [
      :full_messages, :full_message, :generate_messages
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
        it_should_behave_like "a delegated method"
      end
    end
  end
end