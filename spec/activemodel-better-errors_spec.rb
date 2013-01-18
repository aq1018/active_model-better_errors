require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ActiveModel Better Errors" do
  it "overrides ActiveModel Validations" do
    User.new.errors.should be_a ActiveModel::ErrorCollecting::Errors
  end
end
