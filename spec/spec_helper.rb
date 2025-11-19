# frozen_string_literal: true

require 'rails_helper'
require 'composition'

# ENV['RAILS_ENV'] = 'test'

RSpec.configure do |config|
  config.expect_with(:rspec) do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching(:focus)

  # config.use_transactional_fixtures = true
  # config.infer_spec_type_from_file_location!
  # config.filter_rails_from_backtrace!

  config.include ViewComponent::TestHelpers, type: :component
  config.include ViewComponent::SystemTestHelpers, type: :component
  # config.include Capybara::RSpecMatchers, type: :component

  # config.before(:each, type: :component) do
  #   # 各テスト前にビューコンテキストをリセット
  #   @vc_test_controller = nil
  # end

  Dir[File.join(File.dirname(__FILE__), 'fixtures', '**', '*.rb')].sort.each { |f| require f }
end
