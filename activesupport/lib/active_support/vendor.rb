# Prefer gems to the bundled libs.
require 'rubygems'

begin
  gem 'builder', '~> 2.1.2'
rescue Gem::LoadError
  $:.unshift "#{File.dirname(__FILE__)}/vendor/builder-2.1.2"
end
require 'builder'

begin
  gem 'memcache-client', '>= 1.7.4'
rescue Gem::LoadError
  $:.unshift "#{File.dirname(__FILE__)}/vendor/memcache-client-1.7.4"
end

tzinfo_version = ActiveSupport.modern_ruby? ? '0.3.53' : '0.3.12'
begin
  gem 'tzinfo', "~> #{tzinfo_version}"
rescue Gem::LoadError
  $:.unshift "#{File.dirname(__FILE__)}/vendor/tzinfo-#{tzinfo_version}"
end

begin
  gem 'i18n', '>= 0.4.1'
rescue Gem::LoadError
  $:.unshift "#{File.dirname(__FILE__)}/vendor/i18n-0.4.1"
end
require 'i18n'
