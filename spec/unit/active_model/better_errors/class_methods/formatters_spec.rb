# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors, '.formatters' do
  subject { described_class.instance_variable_get :@formatters }

  before { described_class.formatters }

  it { should be_a Registry }
  it { should be described_class.formatters }
end
