require 'logger'

require 'council_tax_fetcher/error'
require 'council_tax_fetcher/configuration'
require 'council_tax_fetcher/dto'
require 'council_tax_fetcher/council_tax_finder_dto'
require 'council_tax_fetcher/council_tax_finder'

class CouncilTaxFetcher
  extend Configure

  BadRequest = Class.new(Error)

  def initialize(postcode:, address:)
    @postcode = postcode
    @address = address
  end

  def council_tax
    CouncilTaxFinder.new(results: council_tax_data, address: @address)
  end

  private

  def council_tax_data
    CouncilTaxFinderDTO.get(postcode: @postcode)
  end
end
