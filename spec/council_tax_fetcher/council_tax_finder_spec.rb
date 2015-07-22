require 'spec_helper'

RSpec.describe CouncilTaxFetcher::CouncilTaxFinder do
  let(:address) { '1 Drapers Court, Lowton, Warrington, WA3 2BT' }
  let(:results) do
    [{ CouncilTaxband: 'A' }, { CouncilTaxband: 'Deleted' }]
  end

  subject(:finder) do
    described_class.new(results: results, address: address)
  end

  it 'returns collection of Result objects', :aggregate_failures do
    expect(finder.results.count).to eq(1)

    finder.each do |record|
      expect(record).to be_an_instance_of(CouncilTaxFetcher::Result)
    end
  end
end
