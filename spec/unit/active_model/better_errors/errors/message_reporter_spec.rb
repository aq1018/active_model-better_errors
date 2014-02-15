# encoding: utf-8

require 'spec_helper'

describe Errors, '#message_reporter' do
  subject { object.send :message_reporter }

  let(:base) { User.new }
  let(:object) { described_class.new(base) }

  it { should be_a Reporter::Message }
end
