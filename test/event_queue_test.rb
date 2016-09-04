require './lib/event_queue'
require 'minitest/autorun'
require 'minitest/pride'

class EventQueueTest < Minitest::Test
  def test_queue_count_starts_at_zero
    queue = EventQueue.new
    assert_equal 0, queue.count
  end
end
