require_relative 'event_data'

class EventReporter
  attr_reader :data, :queue

  def initialize
    @data = EventData.new
    @queue = data.queue
  end

  def get_command
    print "Enter command: "
    gets.chomp.split
  end

  def repl
    command = get_command
    repl_load(command[1]) if command[0] == 'load'
  end

  def repl_load(file)
    @data.load(file)
  end

end
