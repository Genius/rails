require "rails2_ruby2/version"
require "rails2_ruby2/kernel_helpers"

in_ruby2 do
  require 'yaml'
  require 'syck'
end

in_ruby2_when_library_loaded('ActiveSupport', :version_file => 'active_support/version') do
  require 'rails2_ruby2/backport_ruby_config'
  require 'rails2_ruby2/i18n_patch'
  require 'rails2_ruby2/slice_patch'
  require 'rails2_ruby2/tzinfo_patch'
end

in_ruby2_when_library_loaded('ActionController',
   :lib_const_string => 'ActionPack', :version_file => 'action_pack/version') do
  require 'rails2_ruby2/named_route_collection_patch'
  require 'rails2_ruby2/convert_cookies_patch'
  require 'rails2_ruby2/filter_parameters_patch'
  require 'rails2_ruby2/action_controller_perform_action_patch'
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
