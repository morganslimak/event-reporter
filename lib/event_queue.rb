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
      puts row.to_s.gsub(",", "  ")
    end
  end

end
