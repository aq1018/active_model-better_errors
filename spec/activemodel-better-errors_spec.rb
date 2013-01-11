require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ActiveModel::BetterErrors do
  let(:user) { User.new }
  subject(:errors) { user.errors }
  before { user.valid? }

  describe "for human consumer" do
    its(:full_messages) {should == ["First name plz...?", "Last name plz...?"]}
  end

  describe "json reporter" do
    before { errors.reporter = :json }
    its(:to_hash) { should == [] }
  end

end
