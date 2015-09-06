class CouncilTaxFetcher
  module Configure
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
      configuration
    end

    private

    class Configuration
      attr_accessor :domain, :verbose, :log, :logger

      def initialize
        self.domain = nil
        self.verbose = false
        self.log = false
        self.logger = Logger.new(STDOUT)
      end
    end
  end
end
