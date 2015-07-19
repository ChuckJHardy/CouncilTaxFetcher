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
      attr_accessor :verbose

      def initialize
        self.verbose = false
      end
    end
  end
end
