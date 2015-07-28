class CouncilTaxFetcher
  BlankBody = Class.new(StandardError)
  BadRequest = Class.new(StandardError)

  class Validate
    def initialize(response:)
      @response = response
    end

    def self.using(response)
      new(response: response).validate
    end

    def validate
      fail CouncilTaxFetcher::BlankBody, response if blank_body?
      fail CouncilTaxFetcher::BadRequest, response if bad_request?
    end

    protected

    attr_reader :response

    private

    def blank_body?
      response.body.length < 2
    end

    def bad_request?
      response.status != 200
    end
  end
end
