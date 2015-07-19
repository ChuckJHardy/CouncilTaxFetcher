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
      API.public_send(method, url: endpoint, options: params).body
    end

    def params
      {}
    end

    def endpoint
      fail NotImplementedError, 'Inheriting class must implement'
    end
  end
end
