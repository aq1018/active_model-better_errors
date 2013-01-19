class String
  def ==(other)
    return super other.to_s if other.is_a? ActiveModel::ErrorCollecting::ErrorMessage
    super
  end
end