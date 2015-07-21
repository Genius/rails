require "rails2_ruby2/version"
require "rails2_ruby2/kernel_helpers"

in_ruby2 do
  require 'yaml'
  require 'syck'
  require 'rails2_ruby2/backport_ruby_config'
end

module Rails2Ruby2
  extend self

  def self.configure_test_unit_task(task)
    require 'test/unit'

    begin
      require 'test/unit/version'
      if Test::Unit::VERSION >= '2.0'
        task.options = "--collector=object_space"
      end
    rescue LoadError
    end
  end
end
