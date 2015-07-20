class CouncilTaxFetcher
  class NullResult
    attr_reader :postcode, :exception

    def initialize(postcode: nil, exception: nil)
      @postcode = postcode
      @exception = exception
    end

    def valid?
      false
    end

    def as_hash
      {}
    end
  end
end
