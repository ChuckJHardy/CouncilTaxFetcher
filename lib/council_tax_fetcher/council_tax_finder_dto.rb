class CouncilTaxFetcher
  class CouncilTaxFinderDTO < DTO
    def endpoint
      "http://counciltaxfinder.com/mobile/Home/SearchProperty?address=&zipCode=#{postcode}&pageNum=1"
    end

    private

    def postcode
      options.fetch(:postcode)
    end
  end
end
