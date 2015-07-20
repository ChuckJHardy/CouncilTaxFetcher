require 'similar_text'
require 'council_tax_fetcher/result'
require 'council_tax_fetcher/null_result'

class CouncilTaxFetcher
  NoResult = Class.new(StandardError)

  class CouncilTaxFinder
    def initialize(results:, address:)
      @results = results
      @address = address
    end

    def self.result(*args)
      new(*args).result
    end

    def result
      record = @results.select(&checker).first

      if record
        Result.new(data: record)
      else
        NullResult.new(postcode: @address, exception: NoResult.new)
      end
    end

    private

    def checker
      ->(record) { Checker.bingo?(a: record[:Address], b: @address) }
    end

    class Checker
      THRESHOLD = 98

      def initialize(a:, b:)
        @a = sanitize(a)
        @b = sanitize(b)
      end

      def self.bingo?(*args)
        new(*args).bingo?
      end

      def bingo?
        @a.similar(@b) >= THRESHOLD
      end

      def sanitize(string)
        string.downcase.gsub(/[^a-z0-9\s]/i, '')
      end
    end
  end
end
