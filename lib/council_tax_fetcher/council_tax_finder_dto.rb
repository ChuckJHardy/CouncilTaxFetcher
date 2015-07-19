class CouncilTaxFetcher
  class CouncilTaxFinderDTO < DTO
    def initialize(*args)
      super(*args)
      CouncilTaxFetcher.configuration.domain = domain
    end

    def domain
      'http://counciltaxfinder.com/mobile/Home/'
    end

    def endpoint
      "SearchProperty?address=&zipCode=#{postcode}&pageNum=1"
    end

    private

    def postcode
      options.fetch(:postcode)
    end
  end
end
