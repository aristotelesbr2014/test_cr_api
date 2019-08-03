require 'rails_helper'

RSpec.describe Medicine, type: :model do
  let(:valid_attributes) { { name: 'Aspirina', value: 10.0, quantity: 1, stock: 10 } }
  subject { Medicine.new(valid_attributes) }

  context '#total' do
    it 'multiplies' do
      expect(subject.total).to eql 10.0
    end
  end

  describe '#total' do
    context 'When invalid data' do
      let(:invalid_attributes) do
        { name: 'Aspirina', value: nil, quantity: 1, stock: 10 }
      end
      subject { Medicine.new(invalid_attributes) }
      it 'returns error message' do
        expect(subject.total).to eql ['sorry, you must pass a valid amount to value and quantity.']
      end
    end
  end
end
