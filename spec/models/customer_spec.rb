require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'relationships' do
    it { is_expected.to have_many :carts }
  end

  describe '.name' do
    context 'When retuns valid data' do
      let(:valid_attributes) { { name: 'jhon Doe' } }
      subject { Customer.new(valid_attributes) }

      it 'Returns name with first capital letter' do
        expect(subject.name).to eql('Jhon Doe')
      end
    end
  end
end
