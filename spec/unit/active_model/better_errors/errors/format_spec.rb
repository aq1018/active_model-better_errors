# encoding: utf-8

require 'spec_helper'

describe Errors, '#format' do
  subject { object.format(type) }

  let(:base) { User.new }
  let(:object) { described_class.new(base) }
  let(:type) { :foobar }

  its(:formatter_type) { should be type }
end
