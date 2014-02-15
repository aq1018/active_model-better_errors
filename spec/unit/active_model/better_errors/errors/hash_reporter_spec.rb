# encoding: utf-8

require 'spec_helper'

describe Errors, '#hash_reporter' do
  subject { object.send :hash_reporter }

  let(:base) { User.new }
  let(:object) { described_class.new(base) }

  it { should be_a Reporter::Hash }
end
