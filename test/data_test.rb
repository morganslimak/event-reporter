require "./lib/event_data"
require 'minitest/autorun'
require 'minitest/pride'

class DataTest < Minitest::Test
  def test_load_small_csv
    data = EventData.new()
    assert_equal "", data.load("")
  end
end
