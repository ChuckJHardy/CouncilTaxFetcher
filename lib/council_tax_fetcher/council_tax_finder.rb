require 'similar_text'
require 'council_tax_fetcher/result'

class CouncilTaxFetcher
  include Enumerable

  class CouncilTaxFinder
    def initialize(results:, address:)
      @results = results
      @address = address
    end

    def self.results(*args)
      new(*args).results
    end

    def each(&block)
      results.each(&block)
    end

    def results
      @results.map(&result)
    end

    private

    def result
      ->(record) { Result.new(data: record, address: @address) }
    end
  end
end
