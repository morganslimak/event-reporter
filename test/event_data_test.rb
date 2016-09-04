require './lib/event_data'
require 'minitest/autorun'
require 'minitest/pride'

class EventDataTest < Minitest::Test
  def test_load_small_csv
    data = EventData.new()
    data.load("event_attendees.csv")
    assert_equal CSV, data.contents.class
  end
end
