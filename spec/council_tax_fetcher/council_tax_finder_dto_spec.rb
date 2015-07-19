require 'spec_helper'

RSpec.describe CouncilTaxFetcher::CouncilTaxFinderDTO, type: :dto do
  let(:instance) { described_class.new(options: options) }
  let(:postcode) { 'WA3 2BT' }
  let(:options) { { postcode: postcode } }

  describe '#endpoint' do
    let(:expected_endpoint) do
      "SearchProperty?address=&zipCode=#{postcode}&pageNum=1"
    end

    it 'sets the domain' do
      instance.endpoint
      expect(CouncilTaxFetcher.configuration.domain)
        .to eq('http://counciltaxfinder.com/mobile/Home/')
    end

    it 'returns expected url' do
      expect(instance.endpoint).to eq(expected_endpoint)
    end
  end
end
