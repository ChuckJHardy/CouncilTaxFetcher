require 'spec_helper'
require 'council_tax_fetcher/configuration'

RSpec.describe CouncilTaxFetcher::Configure do
  let(:instance) { Class.new { extend CouncilTaxFetcher::Configure } }

  describe '#verbose' do
    subject { instance.configuration.verbose }

    it 'returns a default new_domain' do
      expect(subject).to eq(false)
    end

    it 'returns altered verbose' do
      instance.configure { |config| config.verbose = true }
      expect(subject).to eq(true)
    end
  end
end
