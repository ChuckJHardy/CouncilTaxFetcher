require 'vcr_helper'

RSpec.describe CouncilTaxFetcher do
  let(:instance) do
    described_class.new(postcode: postcode, address: address)
  end

  let(:postcode) { 'TQ137NY' }
  let(:address) { 'Poundsgate, Newton Abbot, Devon TQ13 7NY' }

  describe '#council_tax' do
    it 'returns CouncilTaxFinder object' do
      VCR.use_cassette('valid/council_tax') do
        expect(instance.council_tax.results).to be_an(Array)
      end
    end

    context 'when postcode is invalid' do
      let(:postcode) { 'AA1 OA8' }

      it 'raises error' do
        VCR.use_cassette('invalid/council_tax/bad_request') do
          expect { instance.council_tax }
            .to raise_error(CouncilTaxFetcher::BadRequest)
        end
      end
    end

    context 'when external api error occurs' do
      let(:postcode) { '' }

      it 'raises error' do
        VCR.use_cassette('invalid/council_tax/blank_body') do
          expect { instance.council_tax }
            .to raise_error(CouncilTaxFetcher::BlankBody)
        end
      end
    end
  end
end
