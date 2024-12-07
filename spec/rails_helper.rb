require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'

Capybara.server = :puma, { Silent: true }
# Uncomment if using Docker
# Capybara.server_host = '0.0.0.0'
# Capybara.app_host = 'http://localhost:3000'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  #Favorite Model testing
  config.include Shoulda::Matchers::ActiveModel, type: :model

  # Remove this line if you're not using ActiveRecord or fixtures
  config.fixture_path = Rails.root.join('spec/fixtures')

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Uncomment to auto-load files in spec/support
  Rails.root.glob('spec/support/**/*.rb').sort_by(&:to_s).each { |f| require f }
end
