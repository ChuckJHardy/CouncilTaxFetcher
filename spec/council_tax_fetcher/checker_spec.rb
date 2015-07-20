require 'spec_helper'

RSpec.describe CouncilTaxFetcher::Checker do
  let(:instance) { described_class.new(a: address_a, b: address_b) }

  let(:address_a) { '1 Drapers Court, Lowton, Manchester, WA3 2BT' }
  let(:address_b) { 'My House, 1 Drapers Court, Lowton, Manchester, WA3 2BT' }

  describe '#bingo?' do
    it 'returns true if percentage similarity is higher than threshold' do
      expect(instance.bingo?).to eq(true)
    end
  end

  describe '#percentage' do
    it 'returns percentage similarity' do
      expect(instance.percentage).to eq(90.10989010989012)
    end
  end
end
