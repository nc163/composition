# frozen_string_literal: true

require "spec_helper"
require "view_component"

RSpec.configure do |config|
  # ViewComponentのテスト用設定
  config.include ViewComponent::TestHelpers, type: :component
  config.include ViewComponent::SystemTestHelpers, type: :component
  config.include Capybara::RSpecMatchers, type: :component

  # 
  # config.use_transactional_fixtures = true
  # config.infer_spec_type_from_file_location!
  # config.filter_rails_from_backtrace!
end
