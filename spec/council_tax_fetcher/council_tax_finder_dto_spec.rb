require 'spec_helper'

RSpec.describe CouncilTaxFetcher::NetworkStatsDTO, type: :dto do
  let(:instance) { described_class.new(options: options) }
  let(:network_type) { nil }
  let(:options) do
    {
      lat: 50.7136820,
      lng: -3.5443600,
      distance: 20,
      network_type: network_type
    }
  end

  describe '#endpoint' do
    let(:expected_endpoint) do
      'networkstats.json?lat=50.713682&lng=-3.54436&distance=20&apikey=123&json_format=2'
    end

    it 'returns expected url' do
      expect(instance.endpoint).to eq(expected_endpoint)
    end

    context 'with network_type' do
      let(:network_type) { 3 }
      let(:expected_endpoint) do
        'networkstats.json?lat=50.713682&lng=-3.54436&distance=20&apikey=123&json_format=2&network_type=3'
      end

      it 'returns expected url' do
        expect(instance.endpoint).to eq(expected_endpoint)
      end
    end
  end
end
