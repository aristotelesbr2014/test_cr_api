class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :medicine

  def increment_quantity(amount)
    update_attribute(:quantity, (quantity + amount))
  end

  def decrement_quantity(amount)
    update_attribute(:quantity, (quantity - amount))
  end
end
