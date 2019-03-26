module Rails
  class << self
    if defined?(LTS_ENABLE_GEM_HANDLING)
      def enable_gem_handling?
        LTS_ENABLE_GEM_HANDLING
      end
    elsif defined?(Gem::VERSION) && Gem::VERSION >= '2'
      def enable_gem_handling?
        false
      end
    else
      def enable_gem_handling?
        true
      end
    end
  end
end
