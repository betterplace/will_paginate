begin
  require 'byebug'
rescue LoadError
  # no debugger available
end
if ENV['START_SIMPLECOV'].to_i == 1
  require 'simplecov'
  SimpleCov.start do
    add_filter "#{File.basename(File.dirname(__FILE__))}/"
  end
end
require 'rspec'
require 'view_helpers/view_example_group'
Dir[File.expand_path('../matchers/*_matcher.rb', __FILE__)].each { |matcher| require matcher }

require 'will_paginate'

RSpec.configure do |config|

  config.include Module.new {
    protected

    def include_phrase(string)
      PhraseMatcher.new(string)
    end

    def have_deprecation(msg)
      DeprecationMatcher.new(msg)
    end

    def run_queries(num)
      QueryCountMatcher.new(num)
    end

    def ignore_deprecation
      ActiveSupport::Deprecation.silence { yield }
    end

    def show_queries(&block)
      counter = QueryCountMatcher.new(nil)
      counter.run block
    ensure
      queries = counter.performed_queries
      if queries.any?
        puts queries
      else
        puts "no queries"
      end
    end
  }

  config.backtrace_exclusion_patterns << /view_example_group/
end
