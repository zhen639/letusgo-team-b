
ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'database_cleaner'
require 'capybara/rspec'
require 'test/unit'

require_relative File.join('..', 'app')

Capybara.app = POSApplication
RSpec.configure do |config|
  include Rack::Test::Methods

  config.color = true
  config.tty = true
  config.include Capybara::DSL, feature: true
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  def app
    POSApplication
  end

end
