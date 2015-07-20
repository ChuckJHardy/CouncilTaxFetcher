class CouncilTaxFetcher
  class Result
    def initialize(data:)
      @data = data
    end

    def valid?
      true
    end

    def as_hash
      {
        band: data[:CouncilTaxband],
        reference: data[:LocalAuthorityReferenceNumber],
        county: data[:CName],
        yearly: tax.year,
        monthly: tax.month,
        year: data[:Year],
        link: data[:councilWeb]
      }
    end

    def tax
      @tax ||= Tax.new(data: data)
    end

    protected

    attr_reader :data

    private

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
