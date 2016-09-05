require 'csv'
require_relative 'event_queue'

class EventData
  attr_reader :contents, :queue

  def initialize
    @queue = EventQueue.new
  end

  def load(file)
    @contents = CSV.read file,
      headers: true, header_converters: :symbol
    clean_contents
  end

  def clean_contents
    @contents.by_col!
    2.times {@contents.delete(0)}
    @contents.by_row!
    @contents.each do |row|
      row.each do |key, attribute|
        row[key] = attribute.to_s.strip
        row[key] = attribute.to_s.rjust(5,"0")[0..4] if key == :zipcode
      end
    end
  end

  def find(attribute, criteria)
    @queue.results = @contents.select do |row|
      row[attribute].upcase == criteria.upcase
    end
  end

end
