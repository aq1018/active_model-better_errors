# encoding: utf-8

require 'spec_helper'

describe ErrorCollection, '#added?' do
  let(:object)      { described_class.new base }
  let(:base)        { User.new }
  let(:field)       { :first_name }
  let(:message)     { :invalid }
  let(:options)     { { message: 'no good' } }

  # TODO
  #  write spec
end
