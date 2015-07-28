require 'spec_helper'

RSpec.describe CouncilTaxFetcher::Result do
  let(:instance) { described_class.for(data: data, address: address) }

  let(:address) { 'MY HOUSE, 1, DRAPERS COURT, LOWTON, WARRINGTON, WA3 2BT' }
  let(:data) { result }
  let(:result) do
    {
      Address: '1, DRAPERS COURT, LOWTON, WARRINGTON, WA3 2BT',
      CName: 'WIGAN',
      CouncilTaxband: 'D',
      ImprovementIndicator: '',
      LocalAuthorityReferenceNumber: '03Q267000100',
      Tax: tax,
      TaxMonthly: 'Ã‚Â£216.57-Ã‚Â£220.71',
      Year: '2015-16',
      councilWeb: 'wiganmbc.gov.uk'
    }
  end

  let(:tax) { 'Ã‚Â£2,598.88-Ã‚Â£2,648.52' }

  describe '#object_or_nil' do
    let(:data) { result.merge!(CouncilTaxband: 'Deleted') }

    it 'returns expected hash' do
      expect(instance).to be_nil
    end
  end

  describe '#as_hash' do
    let(:expected_hash) do
      {
        band: 'D',
        address: '1, DRAPERS COURT, LOWTON, WARRINGTON, WA3 2BT',
        reference: '03Q267000100',
        county: 'WIGAN',
        yearly: {
          range: true,
          from: 259_888,
          to: 264_852
        },
        monthly: {
          range: true,
          from: 216_57,
          to: 220_71
        },
        year: '2015-16',
        link: 'wiganmbc.gov.uk',
        estimated_active: true,
        estimated_active_percentage: 90.10989010989012
      }
    end

    it 'returns expected hash' do
      expect(instance.as_hash).to eq(expected_hash)
    end

    context 'when single value amount' do
      let(:tax) { 'Ã‚Â£2,598.88' }

      it 'returns expected hash' do
        expect(instance.as_hash[:yearly])
          .to eq(range: false, from: 259_888, to: 259_888)
      end
    end
  end

  describe '#tax' do
    it 'returns Tax Object', :aggregate_failures do
      expect(instance.tax).to be_an_instance_of(described_class::Tax)
      expect(instance.tax.year).to eq(range: true, from: 259_888, to: 264_852)
      expect(instance.tax.month).to eq(range: true, from: 216_57, to: 220_71)
    end
  end
end
