# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors do
  it 'overrides ActiveModel Validations' do
    User.new.errors.should be_a ActiveModel::BetterErrors::Errors
  end
end
