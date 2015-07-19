require 'spec_helper'
require 'council_tax_fetcher/api'

RSpec.describe CouncilTaxFetcher::API do
  describe '.get' do
    subject { described_class.get(url: url, options: options) }

    let(:url) { '/endpoint/Some Bad URL' }
    let(:options) { { key: 'value' } }

    let(:domain) { CouncilTaxFetcher.configuration.domain }
    let(:connection) { double('Faraday') }

    before do
      allow(Faraday).to receive(:new).with(url: domain) { connection }
    end

    context 'when valid' do
      let(:body) { { networkRank: [] } }
      let(:response) do
        instance_double(Faraday::Response, status: 200, body: body)
      end

      it 'calls off to Faraday' do
        expect(connection).to receive(:get)
          .with('/endpoint/Some%20Bad%20URL', options)
          .and_return(response)

        subject
      end
    end
  end
end
