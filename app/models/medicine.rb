class Medicine < ApplicationRecord
  def total
    return (value * quantity) unless value.nil? || quantity.nil?

    errors.add(:base, 'sorry, you must pass a valid amount to value and quantity.')
  end

  # Validations
  validates :value, :quantity, presence: true

  def unavailable_stock?(amount)
    stock < amount
  end

  def decrement_stock(amount)
    update_attribute(:stock, (stock - amount))
  end

  def increment_stock(amount)
    update_attribute(:stock, (stock + amount))
  end
end
