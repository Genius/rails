if Rails::VERSION::MAJOR == 2 && RUBY_VERSION >= '2.0.0'
  require 'rails2_ruby2/i18n_patch'
  require 'rails2_ruby2/active_record_associations'
  require 'rails2_ruby2/rails_generator_patch'
end
