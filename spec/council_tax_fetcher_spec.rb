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

    context "when postcode is invalid" do
      let(:postcode) { 'AA1 OA8' }

      it 'raises error' do
        VCR.use_cassette('invalid/council_tax/bad_request') do
          expect(instance.council_tax).to have_attributes(
            postcode: postcode,
            exception: an_instance_of(CouncilTaxFetcher::BadRequest)
          )
        end
      end
    end
  end
end
