# encoding: utf-8

require 'spec_helper'

describe ActiveModel::BetterErrors do
  describe 'should work for ActiveRecord::AutosaveAssociation' do
    let(:car) { Car.create(make: 'bmw', model: 'm3') }

    before do
      car.doors.create(position: 'left')
      car.doors.create(position: 'right')
      car.reload
    end

    it 'should create error object on save' do
      car.doors[0].position = 'on the roof'
      expect(car.changed_for_autosave?).to be_true
      car.save

      expect(car.errors).not_to be_nil
    end
  end
end
