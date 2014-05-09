require 'simplecov'
SimpleCov.start 'rails'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/email/rspec'
require 'database_cleaner'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers, type: :feature
  config.include UsefulHelpers
  config.include OauthHelpers

  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.before(:suite) do
    OmniAuth.config.test_mode = true
    DatabaseCleaner.orm       = "mongoid"
    DatabaseCleaner.strategy  = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
    ActionMailer::Base.deliveries.clear
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
