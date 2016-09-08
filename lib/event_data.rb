require 'csv'
require_relative 'event_queue'
require_relative 'attendee'

class EventData
  attr_reader :contents, :queue, :attendees_repo

  def initialize
    @queue = EventQueue.new
    @attendees_repo = []
  end

  def load(file)
    @contents = CSV.read file, headers: true, header_converters: :symbol
    clean_contents
  end

  def clean_contents
    @contents.each do |row|
      clean_row(row)
      @attendees_repo << Attendee.new(row)
    end
  end

  def clean_row(row)
    row.each do |key, attribute|
      row[key] = attribute.to_s.strip
      row[key] = attribute.to_s.rjust(5,"0")[0..4] if key == :zipcode
      row[key] = attribute.to_s.scan(/\d/).join if key == :homephone
    end
  end

  def find(attribute, criteria)
    @queue.results = @attendees_repo.select do |attendee|
      attendee.send(attribute).upcase == criteria.upcase
    end
  end

end
