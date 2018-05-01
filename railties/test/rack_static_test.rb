require 'abstract_unit'

require 'action_controller'
require 'rails/rack'
require 'fileutils'

class RackStaticTest < ActiveSupport::TestCase

  def setup
    @non_public_path = "#{RAILS_ROOT}/non_public_file.html"
    FileUtils.cp_r "#{RAILS_ROOT}/fixtures/public", "#{RAILS_ROOT}/public"
    File.open(@non_public_path, 'w') do |file|
      file.puts "non public content"
    end
  end

  def teardown
    FileUtils.rm_rf "#{RAILS_ROOT}/public"
    FileUtils.rm(@non_public_path)
  end

  DummyApp = lambda { |env|
    [200, {"Content-Type" => "text/plain"}, ["Hello, World!"]]
  }
  App = Rails::Rack::Static.new(DummyApp)

  test "serves dynamic content" do
    assert_equal "Hello, World!", get("/nofile")
  end

  test "serves static index at root" do
    assert_equal "/index.html", get("/index.html")
    assert_equal "/index.html", get("/index")
    assert_equal "/index.html", get("/")
  end

  test "serves static file in directory" do
    assert_equal "/foo/bar.html", get("/foo/bar.html")
    assert_equal "/foo/bar.html", get("/foo/bar/")
    assert_equal "/foo/bar.html", get("/foo/bar")
  end

  test "serves static index file in directory" do
    assert_equal "/foo/index.html", get("/foo/index.html")
    assert_equal "/foo/index.html", get("/foo/")
    assert_equal "/foo/index.html", get("/foo")
  end

  test "does not betray the existance of files outside root" do
    path = "../non_public_file.html"
    assert File.exist?(File.join(RAILS_ROOT, 'public', path))
    assert_equal get("/nofile"), get(path)
  end

  test "does not betray the existance of unreadable files" do
    begin
      filename = 'unreadable.html.erb'
      target = File.join(RAILS_ROOT, 'public', filename)
      FileUtils.touch target
      File.expects(:readable?).with(target).returns(false).at_least_once
      assert File.exist? target
      assert !File.readable?(target)
      path = "/#{filename}"
      assert_equal get("/nofile"), get(path)
    ensure
      File.unlink target
    end
  end

  test "does not betray the existance of files outside root when using alternate path separators" do
    if Dir.pwd.starts_with?('/vagrant')
      $stderr.puts "Can't test file permissions on a vagrant share"
      return
    end
    filename = 'non_public_file.html'
    assert File.exist?(File.join(RAILS_ROOT, filename))
    path = "/%5C..%2F#{filename}"
    assert_equal get("/nofile"), get(path)
  end

  private
    def get(path)
      Rack::MockRequest.new(App).request("GET", path).body
    end
end
