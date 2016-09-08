require './lib/event_queue'
require 'minitest/autorun'
require 'minitest/pride'

class EventQueueTest < Minitest::Test
  def test_queue_results_start_as_empty
    queue = EventQueue.new
    assert queue.results.empty?
    assert_equal 0, queue.results.count
  end

  def test_count_puts_total_elements_in_results_to_terminal
    queue =  EventQueue.new
    queue.results << "attendee1"
    assert_equal nil, queue.count
  end

  def test_queue_clear_emptys_queue
    queue =  EventQueue.new
    queue.results << "attendee1"
    refute queue.results.empty?
    queue.clear
    assert queue.results.empty?
  end
end
