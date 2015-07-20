# Council Tax Fetcher [ ![Codeship Status for ChuckJHardy/CouncilTaxFetcher](https://codeship.com/projects/fe615b20-1126-0133-558e-622995d16682/status?branch=master)](https://codeship.com/projects/92202)

Wrapper for the Council Tax Scraping

## Installation

Add this line to your application's Gemfile:

    gem 'council-tax-fetcher', github: 'ChuckJHardy/CouncilTaxFetcher'

And then execute:

    $ bundle

## Configuration

    CouncilTaxFetcher.configure do |config|
      config.verbose = true
    end

* `verbose` sets the logger level `false`

## Usage

Find Exchange Rate:

    council_tax_fetcher = CouncilTaxFetcher.new(
      postcode: 'WA3 2BT',
      address: '1 Drapers Court, Lowton, Warrington, WA3 2BT'
    )
    # => #<CouncilTaxFetcher:0x>

    council_tax = council_tax_fetcher.council_tax
    # => #<CouncilTaxFetcher::CouncilTaxFinder:0x>

    council_tax.results.first.tax
    # => #<CouncilTaxFetcher::Result::Tax:0x>

    council_tax.results.first.tax.year
    # => 181615

## Testing

    # Includes Rubocop
    $ bin/rspec

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/CouncilTaxFetcher/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
