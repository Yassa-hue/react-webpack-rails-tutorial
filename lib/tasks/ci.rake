# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  # See tasks/linters.rake

  task js_tests: :environment do
    puts Rainbow("Running JavaScript tests").green
    sh "yarn run test:client"
  end

  task rspec_tests: :environment do
    puts Rainbow("Running RSpec tests").green
    sh "rspec"
  end

  desc "Run CI rspec tests"
  task ci_rspec_tests: %i[environment rspec_tests] do
    puts "CI rspec tests"
    puts Rainbow("PASSED").green
    puts ""
  rescue StandardError => e
    puts e.to_s
    puts Rainbow("FAILED").red
    puts ""
    raise(e)
  end

  desc "Run CI js_tests"
  task ci_js_tests: %i[environment js_tests] do
    puts "CI js_tests"
    puts Rainbow("PASSED").green
    puts ""
  rescue StandardError => e
    puts e.to_s
    puts Rainbow("FAILED").red
    puts ""
    raise(e)
  end

  namespace :ci do
    desc "Run all audits and tests"
    # rspec_tests must be before lint and js_tests to build the locale files
    task all: %i[environment rspec_tests lint js_tests] do
      puts "All CI tasks"
      puts Rainbow("PASSED").green
      puts ""
    rescue StandardError => e
      puts e.to_s
      puts Rainbow("FAILED").red
      puts ""
      raise(e)
    end
  end

  task ci: "ci:all"

  task(:default).clear.enhance([:ci])
end
