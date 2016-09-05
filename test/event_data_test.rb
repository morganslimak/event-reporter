require './lib/event_data'
require 'minitest/autorun'
require 'minitest/pride'

class EventDataTest < Minitest::Test

  def test_load_small_csv
    data = EventData.new()
    data.load("event_attendees.csv")
    assert_equal CSV::Table, data.contents.class
  end

  def test_find_data_based_on_first_name
    data = EventData.new()
    data.load("full_event_attendees.csv")
    data.find(:first_name, 'John')
    assert_equal 63, data.queue.results.count
    data.find(:first_name, 'Mary')
    assert_equal 16, data.queue.results.count
  end

  def test_find_data_based_on_state
    data = EventData.new()
    data.load("full_event_attendees.csv")
    data.find(:city, 'Salt Lake City')
    assert_equal 13, data.queue.results.count
  end

  def test_clean_contents_working_for_zipcodes
    data = EventData.new()
    data.load("full_event_attendees.csv")
    data.find(:zipcode, '07306')
    assert_equal 1, data.queue.results.count
  end

end
