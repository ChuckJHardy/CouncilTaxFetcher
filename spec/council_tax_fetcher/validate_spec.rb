require 'spec_helper'

describe CouncilTaxFetcher::Validate do
  subject(:validator) do
    described_class.with(
      method: :get,
      domain: 'www',
      url: 'example.com',
      options: { query: 1 },
      response: response
    )
  end

  let(:response) { double('Faraday::Response', status: status, body: body) }
  let(:body) { { something: :else } }
  let(:status) { 200 }

  before do
    CouncilTaxFetcher.configuration.log = true
    expect(CouncilTaxFetcher.configuration.logger).to receive(:info)
  end

  it 'returns true when nothing is wrong' do
    expect(validator).to be_truthy
  end

  describe 'When BadRequest' do
    let(:status) { 400 }

    it 'raises error' do
      expect { validator }.to raise_error(
        CouncilTaxFetcher::BadRequest
      ) do |e|
        expect(e.message).to eq(
          domain: 'www',
          url: 'example.com',
          options: { query: 1 },
          response: {
            status: status,
            body: body
          }
        )
      end
    end
  end

  describe 'When Blank Body' do
    let(:status) { 200 }
    let(:body) { '' }

    it 'raises error' do
      expect { validator }.to raise_error(
        CouncilTaxFetcher::BlankBody
      ) do |e|
        expect(e.message).to eq(
          domain: 'www',
          url: 'example.com',
          options: { query: 1 },
          response: {
            status: status,
            body: body
          }
        )
      end
    end
  end

  after do
    CouncilTaxFetcher.configuration.log = false
  end
end
