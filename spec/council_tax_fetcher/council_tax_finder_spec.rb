require 'spec_helper'

RSpec.describe CouncilTaxFetcher::CouncilTaxFinder do
  subject(:finder) { described_class.result(results: [result], address: address) }
  let(:address) { '1 Drapers Court, Lowton, Warrington, WA3 2BT' }
  let(:result) { { Address: "1, DRAPERS COURT, LOWTON, WARRINGTON,  WA3 2BT" } }

  context "with match" do
    it 'returns best result' do
      expect(finder).to be_an_instance_of(CouncilTaxFetcher::Result)
    end
  end

  context "without match" do
    let(:result) { { Address: "5, DRAPERS COURT, LOWTON, WARRINGTON,  WA3 2BT" } }

    it 'returns best result', :aggregate_failures do
      expect(finder).to be_an_instance_of(CouncilTaxFetcher::NullResult)
      expect(finder).to have_attributes(
        postcode: address,
        exception: an_instance_of(CouncilTaxFetcher::NoResult)
      )
    end
  end
end
