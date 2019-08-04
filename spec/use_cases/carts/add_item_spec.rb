require 'rails_helper'

RSpec.describe Carts::AddItem do
  let(:custumer) { Customer.create(name: 'jhon Doe') }

  describe '#perform' do
    subject { Carts::AddItem.perform(medicine, cart, amount) }
    context 'When the params are valids' do
      let(:medicine) { Medicine.create(name: 'Aspirina', value: 10.0, quantity: 1, stock: 10) }
      let(:cart) { Cart.create(customer_id: custumer.id) }
      let(:amount) { 1 }

      it 'returns valid instance' do
        expect(subject.valid?).to eql true
      end
      it 'returns cart_item associated' do
        expect(subject.send(:cart).cart_items.size).to eql(1)
      end
      it 'returns id medicine from cart_item' do
        expect(subject.send(:cart).cart_items[0].medicine_id).to eq(medicine.id)
      end
      it 'increment quantity from cart items' do
        expect(subject.send(:cart).cart_items[0].quantity).to eql(1)
      end
      it 'decrement stock from medicine' do
        expect(subject.send(:medicine).stock).to eql(9)
      end
    end

    context 'When no valid stock amount' do
      let(:medicine) { Medicine.create(name: 'Aspirina', value: 10.0, quantity: 1, stock: 1) }
      let(:cart) { Cart.create(customer_id: custumer.id) }
      let(:amount) { 2 }

      it 'returns error messages' do
        expect(subject.errors.messages.fetch(:base)[0]).to eql('Não há quantidade dísponivel em estoque.')
      end
      it 'return init stock amount' do
        expect(subject.send(:medicine).stock).to eql(medicine.stock)
      end
    end
  end
end
