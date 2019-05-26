require "bundler/setup"
require "aruba/rspec"
require "database_cleaner"
require "factory_bot"
require "faker"
require "todo"

ENV["RAILS_ENV"] = "test"
DatabaseCleaner[:active_record].strategy = :deletion

def db_setup
  root_path = File.expand_path('../..', __FILE__)
  db_configuration_file = File.join(root_path, 'db', 'config.yml')
  db_configuration = YAML.load(File.read(db_configuration_file))
  test_config = db_configuration[ ENV["RAILS_ENV"] ]
  test_config["database"] = "#{root_path}/#{test_config["database"]}"

  ActiveRecord::Base.establish_connection(test_config)
  `bundle exec rake db:migrate` unless ::Todo::Task.table_exists?
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:all) do
    db_setup
    DatabaseCleaner.clean
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
