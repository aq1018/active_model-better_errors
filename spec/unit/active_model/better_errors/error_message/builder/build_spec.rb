# encoding: utf-8

require 'spec_helper'

describe ErrorMessage::Builder, '#build' do

  subject { object.build }

  let(:object)    { described_class.new(base, attribute, input, options) }
  let(:base)      { User.new }
  let(:attribute) { :name }

  shared_examples 'a valid ErrorMessage' do
    it              { should be_a ErrorMessage }
    its(:base)      { should eql base }
    its(:attribute) { should eql attribute }
    its(:type)      { should eql type }
    its(:message)   { should eql message }
    its(:options)   { should eql expected_options }
  end

  context 'when override is nil' do
    let(:options)   { {} }
    let(:expected_options) { {} }

    context 'and input is a symbol' do
      let(:input)     { :input_symbol }
      let(:type)      { :input_symbol }
      let(:message)   { nil }

      it_behaves_like 'a valid ErrorMessage'
    end

    context 'and input is string' do
      let(:input)     { 'input_string' }
      let(:type)      { nil }
      let(:message)   { 'input_string' }

      it_behaves_like 'a valid ErrorMessage'
    end

    context 'and input is nil' do
      let(:input)     { nil }
      let(:type)      { nil }
      let(:message)   { nil }

      it_behaves_like 'a valid ErrorMessage'
    end
  end

  context 'when override is a symbol' do
    let(:options)   { { message: override } }
    let(:override)  { :override_symbol }
    let(:expected_options) { {} }

    context 'and input is a symbol' do
      let(:input)     { :input_symbol }
      let(:type)      { :override_symbol }
      let(:message)   { nil }

      it_behaves_like 'a valid ErrorMessage'
    end

    context 'and input is string' do
      let(:input)     { 'input_string' }
      let(:type)      { :override_symbol }
      let(:message)   { 'input_string' }

      it_behaves_like 'a valid ErrorMessage'
    end

    context 'and input is nil' do
      let(:input)     { nil }
      let(:type)      { :override_symbol }
      let(:message)   { nil }

      it_behaves_like 'a valid ErrorMessage'
    end
  end

  context 'when override is a string' do
    let(:options)   { { message: override } }
    let(:override)  { 'override_string' }
    let(:expected_options) { {} }

    context 'and input is a symbol' do
      let(:input)     { :input_symbol }
      let(:type)      { :input_symbol }
      let(:message)   { 'override_string' }

      it_behaves_like 'a valid ErrorMessage'
    end

    context 'and input is string' do
      let(:input)     { 'input_string' }
      let(:type)      { nil }
      let(:message)   { 'override_string' }

      it_behaves_like 'a valid ErrorMessage'
    end

    context 'and input is nil' do
      let(:input)     { nil }
      let(:type)      { nil }
      let(:message)   { 'override_string' }

      it_behaves_like 'a valid ErrorMessage'
    end
  end
end
