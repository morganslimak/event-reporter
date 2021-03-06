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
      case
      when command[0] == 'help'
        help(command)
      when command[0] == 'load' && command.length == 1
        @data.load('event_attendees.csv')
      when command[0] == 'load' && command.length == 2
        @data.load(command[1])
      when command[0] == 'find'
        @data.find(command[1], command.slice(2,command.length-1).join(" "))
      when command[0] == 'queue' && command[1] == 'count'
        @queue.count
      when command[0] == 'queue' && command[1] == 'clear'
        @queue.clear
      when command[0] == 'queue' && command[1] == 'print' && command.length == 2
        @queue.print
      when command[0] == 'queue' && command[1] == 'district'
        @queue.district
      when command[0] == 'queue' && command[1] == 'print' && command[2] == 'by'
        @queue.print_by(command[3])
      when command[0] == 'queue' && command[1] == 'save' && command[2] == 'to'
        @queue.save(command[3])
      when command[0] == 'queue' && command[1] == 'export' && command[2] == 'html'
        @queue.export(command[3])
      end
      command = get_command
    end
  end

  def help(command)
    if command.length == 1
      puts "List of Commands:"
      puts "help, load, find, queue count, queue clear, queue district, "\
           "queue print, queue print by, queue save to, queue export html"
    else
      command = command.slice(1, command.length-1).join(" ")
    end
    case command
    when "help"
      puts "help"
      puts "-Output a listing of the available individual commands"
      puts "help <command>"
      puts "-Output a description of how to use the specific command."
    when "load"
      puts "load <filename>"
      puts "-Erase any loaded data and parse the specified file. If no filenam"\
           "e is given, default to event_attendees.csv."
    when "find"
      puts "find <attribute> <criteria>"
      puts "-Load the queue with all records matching the criteria for the giv"\
           "en attribute."
      puts "-Possible attributes include: last_name, first_name, email"\
           " zipcode, city, state, address, phone"
    when "queue count"
      puts "-Output how many records are in the current queue"
    when "queue clear"
      puts "-Empty the queue"
    when "queue district"
      puts "-If there are less than 10 entries in the queue, this command will"\
           " use the Sunlight API to get Congressional District information fo"\
           "r each entry."
    when "queue print"
      puts "-Print out a tab-delimited data table with a header row."
    when "queue print by"
      puts "queue print by <attribute>"
      puts "-Print the data table sorted by the specified attribute."
      puts "-Possible attributes include: last_name, first_name, email"\
           " zipcode, city, state, address, phone"
    when "queue save to"
      puts "queue save to <filename.csv>"
      puts "-Export the current queue to the specified filename as a CSV."
    when "queue export html"
      puts "queue export html <filename.html>"
      puts "-Export the current queue to the specified filename as a valid HTM"\
           "L file."
    end
  end

end

event_reporter = EventReporter.new
event_reporter.repl
