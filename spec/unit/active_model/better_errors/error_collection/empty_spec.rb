# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#empty?' do
  subject { object.empty? }

  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:field)       { :first_name }

  context 'with no existing errors' do
    it { should be true }
  end

  context 'with pre-existing errors' do
    before { object.set(field, errors) }

    let(:errors)  { [:invalid] }

    it { should be false }
  end
end
