require 'net/http'
require 'json'

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
    puts "LAST NAME".ljust(15)+"FIRST NAME".ljust(15)+"EMAIL".ljust(35)+"ZIPCODE".ljust(10)+"CITY".ljust(20)+"STATE".ljust(10)+"ADDRESS".ljust(45)+"PHONE".ljust(15)+"DISTRICT"
    @results.each do |attendee|
      puts attendee.last_name.ljust(15) + attendee.first_name.ljust(15) + attendee.email.ljust(35) + attendee.zipcode.ljust(10) + attendee.city.ljust(20) + attendee.state.ljust(10) + attendee.address.ljust(45) + attendee.phone.ljust(15) + attendee.district
    end
  end

  def district
    if @results.length < 10
      @results.each do |attendee|
      url = "https://congress.api.sunlightfoundation.com/districts/locate?zip=#{attendee.zipcode}&apikey=d2feb7fe2971453889f66b544ee396c4"
      response = Net::HTTP.get_response(URI.parse(url))
      sunlight_data = JSON.parse(response.body)
      attendee.district = sunlight_data["results"][0]["district"].to_s unless sunlight_data["results"].empty?
      end
    end
  end

  def print_by(attribute)
    @results.sort_by! do |attendee|
      attendee.send(attribute)
    end
    print
  end

end
