require "cases/helper"
require 'models/bird'

module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter
      class QuotingTest < ActiveRecord::TestCase
        def setup
          @conn = ActiveRecord::Base.connection
          @raise_int_wider_than_64bit = ActiveRecord::Base.raise_int_wider_than_64bit
        end

        def test_quote_true
          c = PostgreSQLColumn.new(nil, 1, 'boolean')
          assert_equal "'t'", @conn.quote(true, nil)
          assert_equal "'t'", @conn.quote(true, c)
        end

        def test_quote_false
          c = PostgreSQLColumn.new(nil, 1, 'boolean')
          assert_equal "'f'", @conn.quote(false, nil)
          assert_equal "'f'", @conn.quote(false, c)
        end

        def test_quote_range
          # There is no range support on 2.3's PG adapter, but we still want to
          # make sure that SQL injection is not possible since it was an issue
          # on Rails 4.x.
          # https://groups.google.com/d/msg/rubyonrails-security/wDxePLJGZdI/WP7EasCJTA4J
          #
          # Note that we can not test this using Connection#quote because
          # ActiveRecord expands ranges into two bind variables that are
          # quoted individually.
          range = "1,2]'; SELECT * FROM users; --".."a"
          sql = Bird.scoped(:conditions => { :name => range }).construct_finder_sql({})
          expected_sql = %{SELECT * FROM "birds" WHERE ("birds"."name" BETWEEN '1,2]''; SELECT * FROM users; --' AND 'a') }
          assert_equal expected_sql, sql
        end

        def test_quote_bit_string
          c = PostgreSQLColumn.new(nil, 1, 'bit')
          assert_equal nil, @conn.quote("'); SELECT * FORM users; /*\n01\n*/--", c)
        end

        def test_raise_when_int_is_wider_than_64bit
          value = 9223372036854775807 + 1
          assert_raise ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::IntegerOutOf64BitRange do
            @conn.quote(value)
          end

          value = -9223372036854775808 - 1
          assert_raise ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::IntegerOutOf64BitRange do
            @conn.quote(value)
          end
        end

        def test_do_not_raise_when_int_is_not_wider_than_64bit
          value = 9223372036854775807
          assert_equal "9223372036854775807", @conn.quote(value)

          value = -9223372036854775808
          assert_equal "-9223372036854775808", @conn.quote(value)
        end

        def test_do_not_raise_when_raise_int_wider_than_64bit_is_false
          ActiveRecord::Base.raise_int_wider_than_64bit = false
          value = 9223372036854775807 + 1
          assert_equal "9223372036854775808", @conn.quote(value)
          ActiveRecord::Base.raise_int_wider_than_64bit = @raise_int_wider_than_64bit
        end
      end
    end
  end
end
