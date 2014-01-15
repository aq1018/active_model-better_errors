# encoding: utf-8

require 'spec_helper'

describe ErrorMessage::Builder, '.build' do

  subject { described_class.build(base, attribute, message, options) }

  let(:base)      { User.new }
  let(:attribute) { :name }
  let(:message)   { :invalid }
  let(:options)   { {} }

  it              { should be_a ErrorMessage }
  its(:base)      { should eql base }
  its(:attribute) { should eql attribute }
  its(:type)      { should eql message }
  its(:message)   { should be_nil }
  its(:options)   { should eql Hash.new }

  [:if, :unless, :on, :allow_nil, :allow_blank, :strict].each do |opt|
    context 'when option includes CALLBACK_OPTIONS' do
      let(:options) { { opt => :test } }
      its(:options) { should_not include opt }
    end
  end
end
