class Customer < ApplicationRecord
  has_many :carts

  def name=(str)
    super str.try(:titleize)
  end
end
