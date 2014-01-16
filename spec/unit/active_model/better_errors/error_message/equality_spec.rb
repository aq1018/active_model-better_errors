# encoding: utf-8

require 'spec_helper'

describe ErrorMessage, '#==' do
  subject { left == right }

  let(:builder) { described_class.builder }
  let(:left)    { described_class.new base, field, type, message, {} }
  let(:base)    { User.new }
  let(:field)   { :email }
  let(:type)    { :invalid }
  let(:message) { :nil }

  context 'when right is :invalid' do
    let(:right) { :invalid }
    it { should be_true }
  end

  context 'when right is :no_good' do
    let(:right) { :no_good }
    it { should_not be_true }
  end

  context 'when right is "is invalid"' do
    let(:right) { 'is invalid' }
    it { should be_true }
  end

  context 'when right is "no good"' do
    let(:right) { 'no good' }
    it { should_not be_true }
  end

  context 'when right is nil' do
    let(:right) { nil }
    it { should_not be_true }
  end

  context 'when right is a #to_s ducktype' do
    let(:right) { double }

    context 'and returns "is invalid"' do
      before { right.stub(:to_s).and_return('is invalid') }
      it { should be_true }
    end

    context 'and returns "no good"' do
      before { right.stub(:to_s).and_return('no good') }
      it { should_not be_true }
    end

  end

end
