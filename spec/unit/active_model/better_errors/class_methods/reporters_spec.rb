# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors, '.reporters' do
  subject { described_class.instance_variable_get :@reporters }

  before { described_class.reporters }

  it { should be_a Registry }
  it { should be described_class.reporters }
end
