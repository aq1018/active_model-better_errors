class BasicModel
  extend  ActiveModel::Naming
  extend  ActiveModel::Translation
  include ActiveModel::Validations
  include ActiveModel::Conversion

  def initialize(params={})
    params.each do |attr, value|
      self.public_send("#{attr}=", value)
    end
  end

  def persisted?
    false
  end
end

class User < BasicModel
  attr_accessor :first_name, :last_name

  validates :first_name, :last_name, presence: { message: "plz...?" }
end

class Ruler < BasicModel
  attr_accessor :length

  validates_numericality_of :length, less_than_or_equal_to: 12, greater_than_or_equal_to: 4
end
