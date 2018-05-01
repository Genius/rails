require 'yaml'

module ActiveSupport
  # constant allows people to disable all our Ruby 2 code, if for some reason necessary
  # this is undocumented, because we'd rather it just works for everyone
  if defined?(LTS_MODERN_RUBY)
    def self.modern_ruby?
      LTS_MODERN_RUBY
    end
  elsif RUBY_VERSION >= '2'
    def self.modern_ruby?
      true
    end
  else
    def self.modern_ruby?
      false
    end
  end

  # constant allows people to disable our YAML changes
  if defined?(LTS_YAMLER)
    def self.psych?
      LTS_YAMLER == 'psych'
    end
  # people on 1.9 could potentially have either Syck or Psych
  elsif (defined?(YAML::ENGINE.yamler) ? YAML::ENGINE.yamler != 'syck' : defined?(Psych))
    def self.psych?
      true
    end
  else
    def self.psych?
      false
    end
  end
end
