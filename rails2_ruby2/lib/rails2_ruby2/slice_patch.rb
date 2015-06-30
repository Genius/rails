ActiveSupport::CoreExtensions::Hash::Slice.class_eval do
  def slice(*keys)
    keys = keys.map! { |key| convert_key(key) } if respond_to?(:convert_key, include_all = true)
    hash = self.class.new
    keys.each { |k| hash[k] = self[k] if has_key?(k) }
    hash
  end

  def slice!(*keys)
    keys = keys.map! { |key| convert_key(key) } if respond_to?(:convert_key, include_all = true)
    omit = slice(*self.keys - keys)
    hash = slice(*keys)
    replace(hash)
    omit
  end
end
