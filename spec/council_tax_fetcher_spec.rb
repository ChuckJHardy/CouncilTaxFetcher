require 'vcr_helper'

RSpec.describe CouncilTaxFetcher do
  let(:instance) do
    described_class.new(postcode: postcode, address: address)
  end

  let(:postcode) { 'WA3 2BT' }
  let(:address) { '1 Drapers Court, Lowton, Warrington, WA3 2BT' }

  describe '#council_tax' do
    it 'returns CouncilTaxFinder object' do
      VCR.use_cassette('valid/council_tax') do
        expect(instance.council_tax)
          .to be_an_instance_of(CouncilTaxFetcher::Result)
      end
    end
  end
end
