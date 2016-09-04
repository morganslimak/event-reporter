require './lib/event_data'
require 'minitest/autorun'
require 'minitest/pride'

class EventDataTest < Minitest::Test

  def test_load_small_csv
    data = EventData.new()
    data.load("event_attendees.csv")
    assert_equal CSV, data.contents.class
  end

  def test_find_data_based_on_first_name
    data = EventData.new()
    data.load("full_event_attendees.csv")
    data.find('John')
    assert_equal 63, data.results.count
  end

end
