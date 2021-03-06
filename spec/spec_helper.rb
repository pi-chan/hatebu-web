require 'coveralls'
Coveralls.wear!

require 'rubygems'
require 'spork'
require 'debugger'

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)

  require 'capybara/dsl'
  require 'capybara/rspec'
  require 'capybara/webkit'
  require 'capybara/poltergeist'
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'turnip'
  require 'turnip/capybara'
  require 'database_cleaner'

  Capybara.javascript_driver = :poltergeist

  unless ENV['DRB']
    require 'simplecov'
    require 'simplecov-rcov'
    SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
    SimpleCov.start 'rails'
  end


  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"
    
    config.include Capybara::DSL, :type => :request
    config.include Capybara::RSpecMatchers, :type => :request    

    # jsのテストのためにCapybaraで実際のブラウザを立ち上げているが、
    # そのときにDBへ接続できなくて起きるエラーを回避するため以下の設定が必要
    config.use_transactional_fixtures = false
    config.before(:suite) do
      DatabaseCleaner.clean_with :truncation
    end

    config.before(:each) do
      if example.metadata[:js]
        DatabaseCleaner.strategy = :truncation
      else
        DatabaseCleaner.strategy = :transaction
      end
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.expect_with :rspec do |c|
      c.syntax = :expect
    end
  end

end

Spork.each_run do
  Dir.glob("spec/**/*steps.rb") {|f| load f, true}

  if Spork.using_spork?
    Rails.application.reloaders.each{|reloader| reloader.execute_if_updated }
  end

  unless ENV['DRB']
    require 'simplecov'
    require 'simplecov-rcov'
    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
                                                               SimpleCov::Formatter::HTMLFormatter,
                                                               SimpleCov::Formatter::RcovFormatter,
                                                               Coveralls::SimpleCov::Formatter
                                                              ]
    SimpleCov.start 'rails'
  end
  
end
  
