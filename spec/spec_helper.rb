require File.expand_path('./dummy/config/environment', __dir__)
require 'rspec/rails'
require 'rails-controller-testing'
require 'rectify/rspec'
require 'shoulda/matchers'
require 'capybara/rails'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.ignore_hidden_elements = false

ENGINE_ROOT = File.join(File.dirname(__FILE__), '../')
%w[support factories].each do |folder|
  Dir[File.join(ENGINE_ROOT, "spec/#{folder}/**/*.rb")].each do |file|
    require file
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include FactoryBot::Syntax::Methods
  config.include Rectify::RSpec::Helpers
  config.include Warden::Test::Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include FeatureHelper, type: :feature

  config.after(:each, type: :feature) do
    Warden.test_reset!
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  Shoulda::Matchers.configure do |c|
    c.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
