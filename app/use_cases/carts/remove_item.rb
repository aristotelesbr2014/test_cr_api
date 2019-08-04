module Carts
  # RemoveItem class
  class RemoveItem
    include UseCase

    def initialize(medicine, cart, amount)
      @medicine = medicine
      @cart = cart
      @amount = amount
    end

    def perform
      remove_item unless find_cart_item.blank?
      # sent_notification
    end

    private

    attr_reader :medicine, :cart, :amount

    def find_cart_item
      @cart_item = @cart.cart_items.find_by_medicine_id(@medicine.id)
    end

    def remove_item
      @cart_item.decrement_quantity(@amount) if @medicine.increment_stock(@amount)
      @cart_item.destroy if @cart_item.quantity.zero?
    end

    def handler_error
      errors.add(
        :base,
        'Ocorreu um erro ao adicionar um item o carrinho, tente novamente.'
      )
    end
  end
end
