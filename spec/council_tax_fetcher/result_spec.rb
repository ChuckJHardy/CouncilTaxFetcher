require 'spec_helper'

RSpec.describe CouncilTaxFetcher::Result do
  let(:instance) { described_class.new(data: result) }
  let(:result) do
    {
      Address: "1, DRAPERS COURT, LOWTON, WARRINGTON,  WA3 2BT",
      CName: "WIGAN",
      CouncilTaxband: "D",
      ImprovementIndicator: "",
      LocalAuthorityReferenceNumber: "03Q267000100",
      Tax: "Â£1402.08",
      TaxMonthly: "Â£116.83",
      Year: "2015-16",
      councilWeb: "wiganmbc.gov.uk"
    }
  end

  describe '#valid?' do
    it 'returns true' do
      expect(instance.valid?).to be_truthy
    end
  end

  describe '#as_hash' do
    let(:expected_hash) do
      {
        band: "D",
        reference: "03Q267000100",
        county: "WIGAN",
        yearly: 140208,
        monthly: 11683,
        year: "2015-16",
        link: "wiganmbc.gov.uk"
      }
    end

    it 'returns expected hash' do
      expect(instance.as_hash).to eq(expected_hash)
    end
  end

  describe '#tax' do
    it 'returns Tax Object', :aggregate_failures do
      expect(instance.tax).to be_an_instance_of(described_class::Tax)
      expect(instance.tax.year).to eq(140208)
      expect(instance.tax.month).to eq(11683)
    end
  end
end
