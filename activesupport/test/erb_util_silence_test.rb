require 'abstract_unit'

class ErbUtilSilenceTest < ActiveSupport::TestCase
  def record_stderr
    $stderr = StringIO.new
    yield
    $stderr.string
  ensure
    $stderr = STDERR
  end

  def test_erb_util_html_escape_should_be_silent
    recorded = record_stderr do
      assert_equal "åß∂åß∂&lt;&gt;", ERB::Util.html_escape("åß∂åß∂<>")
    end
    assert_equal "", recorded
  end
end
