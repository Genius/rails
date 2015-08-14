ActiveSupport::TimeZone.prepend(Module.new do
  def parse(str, now=self.now)
    super(str, now)
  end
end)
