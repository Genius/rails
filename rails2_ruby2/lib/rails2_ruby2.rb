require "rails2_ruby2/version"

if RUBY_VERSION >= '2.0.0'
  require 'yaml'
  require 'syck'
end

if defined?(ActiveSupport)
  begin
    require 'active_support/version'
  rescue LoadError
  else
    if ActiveSupport::VERSION::MAJOR == 2 && RUBY_VERSION >= '2.0.0'
      require 'rails2_ruby2/backport_ruby_config'
      require 'rails2_ruby2/i18n_patch'
      require 'rails2_ruby2/slice_patch'
    end
  end
end

if defined?(ActionController)
  begin
    require 'action_pack/version'
  rescue LoadError
  else
    if ActionPack::VERSION::MAJOR == 2 && RUBY_VERSION >= '2.0.0'
      require 'rails2_ruby2/named_route_collection_patch'
      require 'rails2_ruby2/convert_cookies_patch'
      require 'rails2_ruby2/filter_parameters_patch'
    end
  end
end

module Rails2Ruby2
end
