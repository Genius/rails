module ActiveSupport
  # behaves like Ruby 1.8.7 respond_to?, returning true for protected methods
  def self.legacy_respond_to?(object, method, include_private = false)
    object.respond_to?(method, include_private) || object.protected_methods.include?(method.to_sym)
  end
end
