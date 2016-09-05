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
    assert_equal 63, data.results.count
    data.find(:first_name, 'Mary')
    assert_equal 16, data.results.count
  end

  def test_find_data_works_for_all_attributes
    data = EventData.new()
    data.load("full_event_attendees.csv")
    data.find(:city, 'Salt Lake City')
    assert_equal 13, data.results.count
    data.find(:zipcode, '07306')
    assert_equal 13, data.results.count
  end

end
