ActiveSupport::Cache::CompressedMemCacheStore.module_eval do
  def write(name, value, options = nil)
    value = ActiveSupport::Gzip.compress(Marshal.dump(value)).force_encoding('ascii') unless raw?(options)
    super(name, value, (options || {}).merge(:raw => true))
  end
end
