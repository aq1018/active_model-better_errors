# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#include?' do
  subject { object.include?(field) }

  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:field)       { :first_name }

  context 'when errors for attribute is nil' do
    it { should be false }
  end

  context 'when errors for attribute is empty' do
    before { object[field] }
    it { should be false }
  end

  context 'when errors for attribute contain error' do
    before { object[field] << :invalid }
    it { should be true }
  end
end
