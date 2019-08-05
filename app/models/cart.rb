class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_items

  def total
    cart_items.reduce(0) { |sum, item| sum + (item.quantity * item.medicine.value) }
  end
end
