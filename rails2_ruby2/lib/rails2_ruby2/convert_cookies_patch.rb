ActionController::Response.prepend(Module.new do
  private

  def convert_cookies!
    cookies = headers['Set-Cookie'].to_s.lines.to_a.compact
    headers['Set-Cookie'] = cookies unless cookies.empty?
  end
end)
