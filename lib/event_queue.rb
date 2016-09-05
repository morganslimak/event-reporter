class EventQueue
  attr_accessor :results

  def initialize
    @results = []
  end

  def clear
    @results = []
  end

  def count
    puts @results.count
  end

end
