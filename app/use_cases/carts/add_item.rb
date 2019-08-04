# frozen_string_literal: true

module Carts
  # UseCase Add item cart
  class AddItem
    include UseCase

    def initialize(medicine, cart, amount)
      @medicine = medicine
      @cart = cart
      @amount = amount
    end

    def perform
      save_item
      # sent_notification
    end

    private

    attr_reader :medicine, :cart

    def save_item
      @cart_item = @cart.cart_items.find_or_create_by(
        medicine_id: @medicine.id, cart_id: @cart.id
      )

      return stock_error_message if @medicine.unavailable_stock?(@amount)

      @cart_item.increment_quantity(@amount) if @medicine.decrement_stock(@amount)
      @cart_item.save.tap do |_success|
        handle_errors unless success?
      end
    end

    def handle_errors
      errors.add(
        :base,
        'Ocorreu um erro ao adicionar um item o carrinho, tente novamente.'
      )
    end

    def stock_error_message
      errors.add(:base, 'Não há quantidade dísponivel em estoque.')
    end

    def sent_notification; end
  end
end
