class CouncilTaxFetcher
  class Validate
    def initialize(method:, domain:, url:, options:, response:)
      @method = method
      @domain = domain
      @url = url
      @options = options
      @response = response
    end

    def self.with(*args)
      new(*args).validate
    end

    def validate
      log

      # rubocop:disable Style/RaiseArgs
      fail BlankBody.new(error_args) if blank_body?
      fail BadRequest.new(error_args) if bad_request?
      # rubocop:enable Style/RaiseArgs

      true
    end

    private

    attr_reader :response

    def error_args
      {
        domain: @domain,
        url: @url,
        options: @options,
        status: response.status,
        body: response.body
      }
    end

    def blank_body?
      response.body.to_s.length < 2
    end

    def bad_request?
      response.status != 200
    end

    def log
      CouncilTaxFetcher.configuration.logger.info(
        "-> CouncilTaxFetcher Response: #{@method.upcase}\n#{error_args}"
      ) if CouncilTaxFetcher.configuration.log
    end
  end
end

