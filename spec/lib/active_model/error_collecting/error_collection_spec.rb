require 'spec_helper'
require 'active_model/error_collecting/error_collection'
require 'active_model/error_collecting/error_message_set'
require 'active_model/error_collecting/error_message'

describe ActiveModel::ErrorCollecting::ErrorCollection do
  let(:klass) { ActiveModel::ErrorCollecting::ErrorCollection }
  let(:errors) { klass.new(User.new) }

  describe "#[]=" do
    it "adds error" do
      errors[:foo] = 'omg'
      errors[:foo] = 'wtf'
      expect(errors[:foo].length).to eq(2)
    end
  end

  describe "#clear" do
    it "removes all errors" do
      errors[:foo] = 'omg'
      errors.clear
      expect(errors).to be_empty
    end
  end

  describe "#has_key?" do
    context "when the attribute has an error" do
      before { errors.add(:foo, "wtf") }
      it "returns true" do
        expect(errors).to have_key(:foo)
      end
    end

    context "when attribute has empty array" do
      before { errors.set(:foo, []) }
      it "returns false" do
        expect(errors).not_to have_key(:foo)
      end
    end

    context "when empty" do
      it "returns false" do
        expect(errors).not_to have_key(:foo)
      end
    end

  end

  describe "humanity" do
    specify do
      errors.add(:foo, "omg")
      error = errors[:foo].first
      expect(error).not_to be_robot
      expect(error).to be_human
    end

    specify do
      errors.add(:foo, :omg)
      error = errors[:foo].first
      #expect(error).not_to be_human
      expect(error).to be_robot
    end

    specify do
      errors.add(:foo, [:omg, "omg"])
      error = errors[:foo].first
      expect(error).to be_human
      expect(error).to be_robot
    end
  end

  describe "#[]<<" do
    it "adds error" do
      pending "unsupported with this architecture"
      errors[:foo] << [:invalid, 'omg']
      expect(errors[:foo].length).to eq(1)
      expect(errors[:foo].first.key).to eq(:invalid)
      expect(errors[:foo].first.message).to eq('omg')
    end
  end

  describe "#delete" do
    it "removes the error" do
      errors[:foo] = 'omg'
      errors.delete(:foo)
      expect(errors).to be_empty
    end
  end

  describe "#add" do
    it "accepts array values" do
      errors.add :base, [:invalid, "something is not right"]
      expect(errors[:base].length).to eq(1)
    end

    it "accepts strings" do
      errors.set :base, "the user is invalid"
      expect(errors[:base].length).to eq(1)
    end
  end

  describe "#set" do
    it "accepts array values" do
      errors.add(:base, "wtf")
      errors.set :base, ["the user is invalid", "something is not right"]
      expect(errors[:base].length).to eq(2)
    end

    it "accepts strings" do
      errors.set :base, "the user is invalid"
      expect(errors[:base].length).to eq(1)
    end
  end
end
