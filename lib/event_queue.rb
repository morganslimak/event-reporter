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
    puts "LAST NAME".ljust(10)+"FIRST NAME".ljust(20)+"EMAIL".ljust(35)+"ZIPCODE".ljust(10)+"CITY".ljust(20)+"STATE".ljust(10)+"ADDRESS".ljust(45)+"PHONE".ljust(15)+"DISTRICT"
    @results.each do |attendee|
      puts attendee.last_name.ljust(10) + attendee.first_name.ljust(20) + attendee.email.ljust(35) + attendee.zipcode.ljust(10) + attendee.city.ljust(20) + attendee.state.ljust(10) + attendee.address.ljust(45) + attendee.phone.ljust(10)
    end
  end

  def district
    if @results.length < 10
      @results.each do |attendee|
        attendee.district = https://congress.api.sunlightfoundation.com/districts/locate?zip=11216&apikey=d2feb7fe2971453889f66b544ee396c4
      end
    end
  end

end
