require 'spec_helper'
require 'council_tax_fetcher/dto'

RSpec.describe CouncilTaxFetcher::DTO, type: :dto do
  let(:instance) { described_class.new(options: options) }
  let(:options) { {} }

  describe '.get' do
    subject { described_class.get(options) }
    let(:endpoint) { '/endpoint' }

    before do
      allow_any_instance_of(described_class).to receive(:endpoint) { endpoint }
    end

    it 'calls off to API and returns response body' do
      expect(CouncilTaxFetcher::API).to receive(:get)
        .with(url: endpoint, options: options) { double(body: {}) }

      expect(subject).to eq({})
    end
  end

  describe '#params' do
    it 'returns empty hash' do
      expect(instance.params).to eq({})
    end
  end

  describe '#endpoint' do
    let(:msg) { 'Inheriting class must implement' }

    it 'raises an error' do
      expect { instance.endpoint }.to raise_error(NotImplementedError, msg)
    end
  end
end
