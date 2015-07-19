require 'spec_helper'

require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<OPENSIGNAL_API_KEY>') do
    ENV['OPENSIGNAL_API_KEY']
  end
end
