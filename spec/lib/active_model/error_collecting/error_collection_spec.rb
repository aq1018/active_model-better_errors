require 'spec_helper'

describe ActiveModel::ErrorCollecting::ErrorCollection do
  subject(:collection) { klass.new(base) }
  let(:klass) { ActiveModel::ErrorCollecting::ErrorCollection }
  let(:base)  { mock() }
  let(:errors){{
    :name     =>  [ [ :too_long, { count: 3 } ] ],
    'email'   =>  [ [ :invalid, { message: "Invalid" } ] ],
    :address  =>  [ :invalid ],
  }}

  before do
    errors.each do |attribute, error_list|
      error_list.each do |error|
        collection[attribute] = error
      end
    end
  end

  describe "#clear" do
    before { collection.clear }
    it { should be_empty}
  end

  describe "#include?" do
    it { should be_include :name }
    it { should be_include :email }
    it { should_not be_include 'name' }
    it { should_not be_include 'email' }
  end

  describe "#get" do
    subject { collection.get(:name) }
    it { should be_a ActiveModel::ErrorCollecting::ErrorMessageSet }
    its(:length) { should be 1 }

    describe "when value is nil" do
      before { collection.delete :name }
      it { should be_a nil }
    end
  end

  describe "#set" do
    subject { collection[:name] }

    describe "When value is array" do
      before { collection.set(:name, []) }
      it { should be_a ActiveModel::ErrorCollecting::ErrorMessageSet }
      its(:length) { should be 0 }
    end

      describe "When value is nil" do
        before { collection.set(:name, nil) }
        it { should be_nil }
      end
  end

  describe "#delete" do
    subject { collection.get(:name) }
    before { collection.delete(:name) }
    it { should be_nil }
  end

  describe "#[]" do
  end

  describe "#[]=" do
  end

  describe "#each" do
  end

  describe "#size" do
  end

  describe "#values" do
  end

  describe "#keys" do
  end

  describe "#to_a" do
  end

  describe "#count" do
  end

  describe "#empty?" do
  end

  describe "#add" do
  end

  describe "#added" do
  end
end
