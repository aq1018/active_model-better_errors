# encoding: utf-8

require 'spec_helper'

describe Errors, '#formatter_type' do
  subject { object.formatter_type }

  let(:base) { User.new }
  let(:object) { described_class.new(base) }

  it { should be ActiveModel::BetterErrors.default_formatter_type }

  context 'when using non-default formatter' do
    before { object.format(:foobar) }

    it { should be :foobar }
  end
end
