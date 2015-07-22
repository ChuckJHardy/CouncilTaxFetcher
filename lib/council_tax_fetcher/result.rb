require 'council_tax_fetcher/checker'

class CouncilTaxFetcher
  class Result
    def initialize(data:, address:)
      @data = data
      @address = address
    end

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def as_hash
      {
        band: data[:CouncilTaxband],
        address: data[:Address],
        reference: data[:LocalAuthorityReferenceNumber],
        county: data[:CName],
        yearly: tax.year,
        monthly: tax.month,
        year: data[:Year],
        link: data[:councilWeb],
        estimated_active: checker.bingo?,
        estimated_active_percentage: checker.percentage
      }
    end

    def tax
      @tax ||= Tax.new(data: data)
    end

    protected

    attr_reader :data

    private

    def checker
      @checker ||= Checker.new(a: data[:Address], b: @address)
    end

    class Tax
      def initialize(data:)
        @data = data
      end

      def year
        cents(@data[:Tax])
      end

      def month
        cents(@data[:TaxMonthly])
      end

      private

      def cents(string)
        string.downcase.gsub(/[^0-9\s]/i, '').to_i
      end
    end
  end
end
