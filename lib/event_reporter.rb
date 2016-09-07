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
      @data.load('full_event_attendees.csv') if command[0] == 'load' && command.length == 1
      @data.load(command[1]) if command[0] == 'load' && command.length == 2
      @data.find(command[1], command[2]) if command[0] == 'find'
      @queue.count if command[0] == 'queue' && command[1] == 'count'
      @queue.clear if command[0] == 'queue' && command[1] == 'clear'
      @queue.print if command[0] == 'queue' && command[1] == 'print' && command.length == 2
      @queue.district if command[0] == 'queue' && command[1] == 'district'
      @queue.print_by(command[3]) if command[0] == 'queue' && command[1] == 'print' && command[2] == 'by'
      @queue.save(command[3]) if command[0] == 'queue' && command[1] == 'save' && command[2] == 'to'
      command = get_command
    end
  end
end

e = EventReporter.new
e.repl
