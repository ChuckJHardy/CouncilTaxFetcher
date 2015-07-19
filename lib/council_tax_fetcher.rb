require 'council_tax_fetcher/configuration'
require 'council_tax_fetcher/dto'
require 'council_tax_fetcher/council_tax_finder_dto'
require 'council_tax_fetcher/council_tax_finder'

class CouncilTaxFetcher
  extend Configure

  def initialize(postcode:, address:)
    @postcode = postcode
    @address = address
  end

  def council_tax
    CouncilTaxFinder.new(data: council_tax_data)
  end

  private

  def council_tax_data
    CouncilTaxFinderDTO.get(postcode: @postcode)
  end
end
