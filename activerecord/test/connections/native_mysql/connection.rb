print "Using native MySQL\n"
require_dependency 'models/course'
require 'logger'

ActiveRecord::Base.logger = Logger.new("debug.log")

# GRANT ALL PRIVILEGES ON activerecord_unittest.* to 'rails'@'localhost';
# GRANT ALL PRIVILEGES ON activerecord_unittest2.* to 'rails'@'localhost';

ActiveRecord::Base.configurations = {
  'arunit' => {
    :adapter  => 'mysql',
    :username => ENV['MYSQL_USER'],
    :encoding => 'utf8',
    :database => 'activerecord_unittest',
    :host     => ENV['MYSQL_HOST'],
  },
  'arunit2' => {
    :adapter  => 'mysql',
    :username => ENV['MYSQL_USER'],
    :database => 'activerecord_unittest2',
    :host     => ENV['MYSQL_HOST'],
  }
}

ActiveRecord::Base.establish_connection 'arunit'
Course.establish_connection 'arunit2'
