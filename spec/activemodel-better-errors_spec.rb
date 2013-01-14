require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'pry'

describe ActiveModel::ErrorCollecting do
  require 'spec_helper'

  describe "numericality check" do
    let(:ruler) { Ruler.new(length: 13) }
    subject(:errors) { ruler.errors }
    before { ruler.valid? }

    describe "for human consumer" do
      its(:full_messages) { should == ["Length must be less than or equal to 12"] }
    end

    describe "json reporter" do
      its(:to_hash) { should == { :length => [:less_than_or_equal_to] } }
    end
  end

  describe "presence check" do
    let(:user) { User.new }
    subject(:errors) { user.errors }
    before { user.valid? }

    describe "for human consumer" do
      its(:full_messages) { should == ["First name plz...?", "Last name plz...?"] }
    end

    describe "json reporter" do
      its(:to_hash) { should == { :first_name => [:blank], :last_name => [:blank] } }
    end
  end
end
