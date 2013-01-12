require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ActiveModel::ErrorCollecting do
  let(:user) { User.new }
  subject(:errors) { user.errors }
  before { user.valid? }

  describe "for human consumer" do
    its(:full_messages) {should == ["First name plz...?", "Last name plz...?"]}
  end

  describe "json reporter" do
    its(:to_hash) { should == { :first_name => [:blank], :last_name => [:blank] } }
  end

end
