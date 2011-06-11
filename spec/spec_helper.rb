require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  ENV["RAILS_ENV"] ||= 'test'
  unless defined?(Rails)
    require File.dirname(__FILE__) + "/../config/environment"
  end

  require 'rspec/rails'
  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
  Rspec.configure do |config|
    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    ActiveSupport::Dependencies.clear

    def test_sign_in(user)
      controller.sign_in(user)
    end
    def integration_sign_in(user)
      visit signin_path
      fill_in :email, :with => user.email
      fill_in :password, :with => user.password
      click_button
    end

  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
end


