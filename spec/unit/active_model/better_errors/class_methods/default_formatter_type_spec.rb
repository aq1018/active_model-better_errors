# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors, '.default_formatter_type' do
  subject { described_class.default_formatter_type }

  it { should be :human }
end
