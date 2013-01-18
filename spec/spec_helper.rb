require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  require 'devise'
  require 'cancan'

  require File.expand_path("../dummy/config/environment.rb", __FILE__)

  require 'rspec/rails'
  require 'capybara/rspec'
  require 'ffaker'
  require 'database_cleaner'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[RolesUi::Engine.root.join("spec/support/**/*.rb")].each { |f| require f }

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = false

    config.before(:suite) { DatabaseCleaner.strategy = :truncation }
    config.before(:each)  { DatabaseCleaner.start }
    config.after(:each)   { DatabaseCleaner.clean }
  end
end

Spork.each_run do
end

def stub_current_user(user)
  controller.stub!(:current_user).and_return(user)
end




