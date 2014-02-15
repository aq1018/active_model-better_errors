# encoding: utf-8

require 'spec_helper'

describe Errors, '#reporter_for' do
  subject { object.send :reporter_for, type }

  let(:base) { User.new }
  let(:object) { described_class.new(base) }
  let(:type) { :array }

  it { should be_a Reporter::Array }
  its(:collection) { should be object.send(:error_collection) }
  its(:formatter_type) { should be object.send(:formatter_type) }
end
