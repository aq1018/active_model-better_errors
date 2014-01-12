# encoding: utf-8

#
# String
#
class String
  def ==(other)
    if other.is_a? ActiveModel::BetterErrors::ErrorMessage
      return super other.to_s
    else
      super
    end
  end
end
