class CouncilTaxFetcher
  class NullResult
    def valid?
      false
    end

    def as_hash
      {}
    end
  end
end
