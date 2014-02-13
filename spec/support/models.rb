# encoding: utf-8

# :nodoc:
class BasicModel
  extend  ActiveModel::Naming
  extend  ActiveModel::Translation
  include ActiveModel::Validations
  include ActiveModel::Conversion

  def initialize(params = {})
    @data = params
  end

  def persisted?
    false
  end

  private

  def read_attribute_for_validation(key)
    @data[key]
  end
end

# :nodoc:
class User < BasicModel
  validates :first_name, :last_name, presence: { message: 'plz...?' }
end

# :nodoc:
class Ruler < BasicModel
  validates_numericality_of :length,
                            less_than_or_equal_to: 12,
                            greater_than_or_equal_to: 4
end
