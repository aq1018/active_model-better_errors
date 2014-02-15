# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors, '.default_formatter_class' do
  subject { described_class.default_formatter_class }

  it { should be Formatter::Human }
end
