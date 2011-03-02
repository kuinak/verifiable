require "verifiable"
require "test/unit"
require "test/user"
require "test/phone_number"
require "sqlite3"
require "ruby-debug"

module Test::Unit
  class TestCase
    def setup
      $VERBOSE = nil
      ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => "test/.verifiable.sqlite3")
      ActiveRecord::Base.logger = Logger.new(File.join(File.dirname(__FILE__), "test.log"))

      ActiveRecord::Base.silence do
        ActiveRecord::Migration.verbose = false
        load(File.join(File.dirname(__FILE__), "schema.rb"))
      end
    end
  end
end
