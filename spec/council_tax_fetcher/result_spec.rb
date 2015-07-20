require 'spec_helper'

RSpec.describe CouncilTaxFetcher::Result do
  let(:instance) { described_class.new(data: result, address: address) }

  let(:address) { 'MY HOUSE, 1, DRAPERS COURT, LOWTON, WARRINGTON, WA3 2BT' }
  let(:result) do
    {
      Address: '1, DRAPERS COURT, LOWTON, WARRINGTON, WA3 2BT',
      CName: 'WIGAN',
      CouncilTaxband: 'D',
      ImprovementIndicator: '',
      LocalAuthorityReferenceNumber: '03Q267000100',
      Tax: 'Â£1402.08',
      TaxMonthly: 'Â£116.83',
      Year: '2015-16',
      councilWeb: 'wiganmbc.gov.uk'
    }
  end

  describe '#as_hash' do
    let(:expected_hash) do
      {
        band: 'D',
        reference: '03Q267000100',
        county: 'WIGAN',
        yearly: 140_208,
        monthly: 116_83,
        year: '2015-16',
        link: 'wiganmbc.gov.uk',
        estimated_active: true,
        estimated_active_percentage: 90.10989010989012
      }
    end

    it 'returns expected hash' do
      expect(instance.as_hash).to eq(expected_hash)
    end
  end

  describe '#tax' do
    it 'returns Tax Object', :aggregate_failures do
      expect(instance.tax).to be_an_instance_of(described_class::Tax)
      expect(instance.tax.year).to eq(140_208)
      expect(instance.tax.month).to eq(116_83)
    end
  end
end
