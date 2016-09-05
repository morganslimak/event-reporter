require "./lib/event_reporter.rb"
require 'minitest/autorun'
require 'minitest/pride'

class EventReporterTest < Minitest::Test
  def test_repl
    reporter = EventReporter.new
    reporter.repl
    assert_equal "", reporter.repl
  end
end
