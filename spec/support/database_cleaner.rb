RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:active_record].strategy = :transaction
    DatabaseCleaner[:active_record].clean_with(:truncation)
  end

  config.around(:each) do |example|
    if example.metadata[:js]
      DatabaseCleaner[:active_record].strategy = :truncation
    else
      DatabaseCleaner[:active_record].strategy = :transaction
    end

    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
