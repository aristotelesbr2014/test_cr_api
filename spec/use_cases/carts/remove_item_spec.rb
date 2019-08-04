require 'rails_helper'

RSpec.describe Carts::RemoveItem do
  let(:custumer) { Customer.create(name: 'jhon Doe') }
  let(:medicine) { Medicine.create(name: 'Aspirina', value: 10.0, quantity: 1, stock: 10) }
  let(:cart) { Cart.create(customer_id: custumer.id) }

  describe '#perform' do
    before do
      Carts::AddItem.perform(medicine, cart, 10)
    end
    subject { Carts::RemoveItem.perform(medicine, cart, 5) }
    context 'When the params are valids' do
      it 'returns valid instance' do
        expect(subject.valid?).to eql true
      end
      it 'returns empty cart items' do
        expect(subject.send(:cart).cart_items.size).to eql(1)
      end
      it 'returns id medicine from cart_item' do
        expect(subject.send(:cart).cart_items[0].medicine_id).to eq(medicine.id)
      end
      it 'decrement quantity from cart items' do
        expect(subject.send(:cart).cart_items[0].quantity).to eql(5)
      end
      it 'increment stock from medcine' do
        expect(subject.send(:medicine).stock).to eql(5)
      end
    end

    context 'When no valid stock amount' do
    end
  end
end
