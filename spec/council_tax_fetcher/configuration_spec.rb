require 'spec_helper'
require 'council_tax_fetcher/configuration'

RSpec.describe CouncilTaxFetcher::Configure do
  let(:instance) { Class.new { extend CouncilTaxFetcher::Configure } }

  describe '#domain' do
    subject { instance.configuration.domain }

    let(:default_domain) { nil }
    let(:new_domain) { 'http://localhost:1111' }

    it 'returns a default new_domain' do
      expect(subject).to eq(default_domain)
    end

    it 'returns altered new domain' do
      instance.configure { |config| config.domain = new_domain }
      expect(subject).to eq(new_domain)
    end
  end

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

  describe '#log' do
    subject { instance.configuration.log }

    it 'returns default' do
      expect(subject).to eq(false)
    end

    it 'returns altered' do
      instance.configure { |config| config.log = true }
      expect(subject).to eq(true)
    end
  end

  describe '#logger' do
    subject { instance.configuration.logger }

    it 'returns default' do
      expect(subject).to be_an_instance_of(Logger)
    end

    it 'returns altered' do
      instance.configure { |config| config.logger = nil }
      expect(subject).to be_nil
    end
  end
end
