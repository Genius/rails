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

module Rails2Ruby2
end
