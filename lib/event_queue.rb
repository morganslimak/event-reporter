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

  def print
    puts "LAST NAME  FIRST NAME  EMAIL  ZIPCODE  CITY  STATE  ADDRESS  PHONE  DISTRICT"
    @results.each do |row|
      row[0], row[1], row[3], row[7], row[4], row[5], row[6] =
        row[1], row[0], row[7], row[3], row[5], row[6], row[4]
      tabbed_row = row.to_s.gsub(",", "  ")
      puts tabbed_row
    end
  end

end
