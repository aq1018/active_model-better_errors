# encoding: utf-8

require 'spec_helper'

describe ActiveModel::ErrorCollecting::HumanMessageFormatter do
  subject(:formatter) { klass.new base, error_message }
  let(:klass)         { ActiveModel::ErrorCollecting::HumanMessageFormatter }
  let(:base)          { User.new }
  let(:error_message) { ActiveModel::ErrorCollecting::ErrorMessage.build base, :first_name, :invalid }

  describe '#initialize' do
    its(:base) { should be base }
    its(:error_message) { should be error_message }
    its(:attribute) { should be error_message.attribute }
    its(:type) { should be error_message.type }
    its(:message) { should be error_message.message }
    its(:options) { should be error_message.options }
  end

  describe '#format_message' do
    subject { formatter.format_message }
    it { should == 'is invalid' }
  end
end
