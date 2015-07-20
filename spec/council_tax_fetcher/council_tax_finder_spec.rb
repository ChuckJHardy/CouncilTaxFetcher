require 'spec_helper'

RSpec.describe CouncilTaxFetcher::CouncilTaxFinder do
  let(:address) { '1 Drapers Court, Lowton, Warrington, WA3 2BT' }
  let(:result) { { Address: '1, DRAPERS COURT, LOWTON, WARRINGTON,  WA3 2BT' } }

  subject(:finder) do
    described_class.new(results: [result], address: address)
  end

  it 'returns collection of Result objects' do
    finder.each do |record|
      expect(record).to be_an_instance_of(CouncilTaxFetcher::Result)
    end
  end
end
