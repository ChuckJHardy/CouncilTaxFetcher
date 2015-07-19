require 'vcr_helper'

RSpec.describe CouncilTaxFetcher do
  let(:instance) do
    described_class.new(
      lat: lat, lng: lng, distance: distance, network_type: network_type
    )
  end

  let(:lat) { 52.629729 }
  let(:lng) { -1.131592 }
  let(:distance) { '22' }
  let(:network_type) { nil }

  before do
    CouncilTaxFetcher.configuration.api_key = ENV['OPENSIGNAL_API_KEY']
  end

  describe '#network_stats' do
    context 'with results' do
      it 'returns NetworkStats object' do
        VCR.use_cassette('valid/network_stats/3g') do
          expect(instance.network_stats)
            .to be_an_instance_of(CouncilTaxFetcher::NetworkStats)
        end
      end
    end

    context 'with no results' do
      let(:network_type) { 5 }

      it 'raises error' do
        VCR.use_cassette('invalid/network_stats/no_results') do
          expect { instance.network_stats }
            .to raise_error(CouncilTaxFetcher::NoResults)
        end
      end
    end

    context 'with bad request' do
      let(:lat) { 50000 }

      it 'raises error' do
        VCR.use_cassette('invalid/network_stats/bad_request') do
          expect { instance.network_stats }
            .to raise_error(CouncilTaxFetcher::BadRequest)
        end
      end
    end
  end
end
