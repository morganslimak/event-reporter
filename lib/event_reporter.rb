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
    until command[0] == 'quit'
      @data.load(command[1]) if command[0] == 'load'
      @data.find(command[1].to_sym, command[2]) if command[0] == 'find'
      @queue.count if command[0] == 'queue' && command[1] == 'count'
      @queue.clear if command[0] == 'queue' && command[1] == 'clear'
      @queue.print if command[0] == 'queue' && command[1] == 'print'
      command = get_command
    end
  end

end
