# encoding: utf-8

require 'spec_helper'

describe Errors, '#error_collection' do
  subject { object.instance_variable_get(:@error_collection) }

  let(:base) { User.new }
  let(:object) { described_class.new(base) }
  let(:type) { :foobar }

  before { object.send :error_collection }

  it { should be_a ErrorCollection }
  its(:base) { should be base }
  it { should be object.send(:error_collection) }
end
