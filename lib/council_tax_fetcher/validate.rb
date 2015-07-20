class CouncilTaxFetcher
  BadRequest = Class.new(StandardError)

  class Validate
    def initialize(response:)
      @response = response
    end

    def self.using(response)
      new(response: response).validate
    end

    def validate
      fail CouncilTaxFetcher::BadRequest if bad_request?
    end

    protected

    attr_reader :response

    private

    def bad_request?
      response.status == 500
    end
  end
end
