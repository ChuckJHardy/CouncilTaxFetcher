require 'council_tax_fetcher/api'

class CouncilTaxFetcher
  class DTO
    attr_reader :options

    def initialize(options:)
      @options = options
    end

    def self.get(options = {})
      new(options: options).response(:get)
    end

    def response(method)
      log(method: method)
      API.public_send(method, url: endpoint, options: params).body
    end

    def params
      {}
    end

    def endpoint
      fail NotImplementedError, 'Inheriting class must implement'
    end

    private

    def domain
      CouncilTaxFetcher.configuration.domain
    end

    def log(method:)
      CouncilTaxFetcher.configuration.logger.info([
        "-> CouncilTaxFetcher Request: #{method.upcase}",
        "domain: #{domain}",
        "endpoint: #{endpoint}",
        'api_key: NONE',
        "params: #{params}"
      ].join("\n")) if CouncilTaxFetcher.configuration.log
    end
  end
end
