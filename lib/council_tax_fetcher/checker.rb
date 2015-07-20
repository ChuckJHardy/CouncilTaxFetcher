class CouncilTaxFetcher
  class Checker
    THRESHOLD = 90

    def initialize(a:, b:)
      @a = sanitize(a)
      @b = sanitize(b)
    end

    def bingo?
      percentage >= THRESHOLD
    end

    def percentage
      @a.similar(@b)
    end

    def sanitize(string)
      string.downcase.gsub(/[^a-z0-9\s]/i, '')
    end
  end
end
