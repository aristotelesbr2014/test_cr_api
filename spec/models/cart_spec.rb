require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:custumer) { Customer.create(name: 'jhon Doe') }
  let(:medicine) { Medicine.create(name: 'Aspirina', value: 10.0, quantity: 1, stock: 10) }
  let(:cart) { Cart.create(customer_id: custumer.id) }

  context 'relationships' do
    it { is_expected.to belong_to :customer }
  end

  describe '#total' do
    subject { Carts::AddItem.perform(medicine, cart, 10) }
    context 'Total itens' do
      it 'returns total of cart' do
        expect(subject.send(:cart).total).to eql(100.0)
      end
    end
  end
end
