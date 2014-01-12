# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors::ErrorCollection do
  subject(:collection) { klass.new(base) }
  let(:klass) { ActiveModel::BetterErrors::ErrorCollection }
  let(:base)  { User.new }
  let(:errors) do
    {
      :first_name =>  [[:too_long, { count: 3 }]],
      'last_name' =>  [[:invalid, { message: 'Invalid' }]],
      :email  =>  [:invalid],
    }
  end

  before do
    errors.each do |attribute, error_list|
      error_list.each do |error|
        collection[attribute] = error
      end
    end
  end

  describe '#clear' do
    before { collection.clear }
    it { should be_empty }
  end

  describe '#include?' do
    it { should be_include :first_name }
    it { should be_include :last_name }
    it { should be_include :email }
    it { should_not be_include 'first_name' }
    it { should_not be_include 'last_name' }
    it { should_not be_include 'email' }
  end

  describe '#get' do
    subject { collection.get(:first_name) }
    it { should be_a ActiveModel::BetterErrors::ErrorMessageSet }
    its(:length) { should be 1 }

    describe 'when value is nil' do
      before { collection.delete :first_name }
      it { should be nil }
    end
  end

  describe '#set' do
    subject { collection.get :first_name }

    describe 'when value is array' do
      before { collection.set(:first_name, []) }
      it { should be_a ActiveModel::BetterErrors::ErrorMessageSet }
      its(:length) { should be 0 }
    end

    describe 'when value is nil' do
      before { collection.set(:first_name, nil) }
      it { should be_nil }
    end
  end

  describe '#delete' do
    subject { collection.get(:first_name) }
    before { collection.delete(:first_name) }
    it { should be_nil }
  end

  describe '#[]' do
    subject { collection[:first_name] }

    describe 'when no error messages' do
      before { collection.clear }
      it { should be_blank }
      it { should_not be_nil }
      it { should be_a ActiveModel::BetterErrors::ErrorMessageSet }
    end

    describe 'when there are error messages' do
      it { should_not be_blank }
      it { should_not be_nil }
      it { should be_a ActiveModel::BetterErrors::ErrorMessageSet }
    end
  end

  describe '#[]=' do
    subject(:error_message_set) { collection.get field }

    describe 'when assigning existing attribute' do
      let(:field) { :first_name }
      it 'should append to existing set' do
        expect do
          collection[field] = "I'm invalid."
        end.to change { error_message_set.length }.by(1)
      end
    end

    describe 'when assigning to new attribute' do
      let(:field) { :a_new_attribute }
      before { collection[field] = "I'm invalid" }
      it { should_not be_nil }
      it { should be_a ActiveModel::BetterErrors::ErrorMessageSet }
      its(:length) { should be 1 }
    end
  end

  describe '#each' do
    it 'should loop through each error' do
      count = 0
      collection.each do |attribute, error|
        attribute.should be_a Symbol
        error.should be_a ActiveModel::BetterErrors::ErrorMessage
        count += 1
      end

      expect(count).to be collection.size
    end
  end

  describe '#size' do
    subject { collection.size }
    it { should be 3 }

    describe 'when adding one more error' do
      before { collection[:name] = 'Not Valid' }
      it { should be 4 }
    end
  end

  describe '#values' do
    subject { collection.values }

    it { should be_a Array }
    its(:length) { should be 3 }

    it 'should contain ErrorMessageSet as elements' do
      collection.values.each do |el|
        el.should be_a ActiveModel::BetterErrors::ErrorMessageSet
      end
    end
  end

  describe '#keys' do
    subject { collection.keys }
    it { should == [:first_name, :last_name, :email] }
  end

  describe '#to_a' do
    subject { collection.to_a }
    its(:size) { should == 3 }

    describe 'when adding one more error' do
      before { collection[:name] = 'Not Valid' }
      its(:size) { should == 4 }
    end

    it 'should contain ErrorMessage as elements' do
      collection.to_a.each do |error|
        error.should be_a ActiveModel::BetterErrors::ErrorMessage
      end
    end
  end

  describe '#to_hash' do
    subject { collection.to_hash }

    it { should be_a Hash }
    it { should == collection.instance_variable_get(:@collection) }
    it { should_not be collection.instance_variable_get(:@collection) }
  end

  describe '#empty?' do
    subject { collection.empty? }
    it { should be false }

    describe 'after clearing the collection' do
      before { collection.clear }

      it { should be true }
    end
  end

  describe '#add' do
    it 'should add error to collection' do
      expect do
        collection.add(:name, 'Invalid')
      end.to change { collection[:name].length }.by(1)
    end
  end

  describe '#added?' do
    describe 'when an error message is not added' do
      subject { collection.added? :name, :not_there }
      it { should be false }
    end

    describe 'when an error message with the same option is added' do
      subject { collection.added? :first_name, :too_long, count: 3 }
      it { should be true }
    end

    describe 'when an error message with the different option is added' do
      subject { collection.added? :first_name, :too_long, count: 4 }
      it { should be false }
    end
  end
end
