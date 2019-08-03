class Medicine < ApplicationRecord
  def total
    return (value * quantity) unless value.nil? || quantity.nil?

    errors.add(:base, 'sorry, you must pass a valid amount to value and quantity.')
  end

  # Validations
  validates :value, :quantity, presence: true
end
