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

  describe '#unavailable_stock?' do
    let(:medicine) { { name: 'Aspirina', value: 10.0, quantity: 1, stock: 1 } }
    context 'When unavailable stock' do
      let(:amount) { 10 }
      subject { Medicine.new(medicine) }

      it 'returns true true' do
        expect(subject.unavailable_stock?(amount)).to be_truthy
      end
    end

    context 'When available stock' do
      let(:amount) { 1 }
      subject { Medicine.new(medicine) }

      it 'returns false value' do
        expect(subject.unavailable_stock?(amount)).to be_falsey
      end
    end
  end

  describe '#decrement_stock' do
    before do
      subject { Medicine.new(name: 'Aspirina', value: 10.0, quantity: 1, stock: 1) }
      subject.decrement_stock(5)
    end
    context 'When update stock' do
      it 'update current stock' do
        expect(subject).to be_truthy
      end
      it 'return new stock' do
        expect(subject.stock).to eql(5)
      end
    end
  end

  describe 'Validations' do
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:quantity) }
  end
end
