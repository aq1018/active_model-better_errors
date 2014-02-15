# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors, '.reporter_types' do
  subject { described_class.reporter_types }

  it { should include :message }
  it { should include :hash }
  it { should include :array }
end
