# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
  c.ignore_request do |request|
    URI(request.uri).port == 3000
  end
  c.cassette_library_dir = 'cassettes'
end


#  for VCR documentation/ignore_request
# https://relishapp.com/vcr/vcr/v/3-0-1/docs/test-frameworks/usage-with-rspec-metadata
#   c.treat_symbols_as_metadata_keys_with_true_values = true
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end
end
