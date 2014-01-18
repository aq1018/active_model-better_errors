# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors::ErrorMessageSet do
  subject(:set)   { klass.new base, attribute, errors }
  let(:klass)     { ActiveModel::BetterErrors::ErrorMessageSet }
  let(:attribute) { :first_name }
  let(:errors)    { [] }
  let(:base)      { User.new }

  describe '#to_a' do
    let(:errors) { [:invalid, :too_long] }
    subject { set.to_a }

    it { should be_a Array }
    its(:length) { should == 2 }
  end

  describe '#empty?' do
    subject { set.empty? }

    describe 'when no error messages' do
      it { should be_true }
    end

    describe 'when contains error messages' do
      let(:errors) { [:invalid, :too_long] }
      it { should be_false }
    end
  end

  describe '#==' do
    subject { errors == set }
    let(:errors) { [:invalid] }
    let(:expected) { ['is invalid'] }
    specify do
      set.should == expected
    end

    specify do
      expected.should == set
    end
  end
end
