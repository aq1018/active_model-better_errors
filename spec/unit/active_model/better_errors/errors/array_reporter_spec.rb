# encoding: utf-8

require 'spec_helper'

describe Errors, '#array_reporter' do
  subject { object.send :array_reporter }

  let(:base) { User.new }
  let(:object) { described_class.new(base) }

  it { should be_a Reporter::Array }
end
