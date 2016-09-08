require 'net/http'
require 'json'
require 'erb'

class EventQueue
  attr_accessor :results

  def initialize
    @results = []
    @attributes = ["last_name", "first_name", "email", "zipcode", "city",
                  "state", "address", "phone", "district"]
  end

  def clear
    @results = []
  end

  def count
    puts @results.count
  end

  def print
    headers = ["LAST NAME", "FIRST NAME", "EMAIL", "ZIPCODE", "CITY",
              "STATE", "ADDRESS", "PHONE", "DISTRICT"]
    max_lengths = find_max_lengths
    headers_and_lengths = headers.zip(max_lengths)
    formatted_headers = ""
    headers_and_lengths.each do |header, length|
      formatted_headers += header.ljust(length)
    end
    puts formatted_headers
    attributes_and_lengths = @attributes.zip(max_lengths)
    @results.each do |attendee|
      formatted_attributes = ""
      attributes_and_lengths.each do |attribute, length|
        formatted_attributes += attendee.send(attribute).ljust(length)
      end
      puts formatted_attributes
    end
  end

  def find_max_lengths
    max_lengths = []
    @attributes.each do |attribute|
      sorted_by_attribute = @results.sort_by do |attendee|
        attendee.send(attribute).length
      end
      if sorted_by_attribute.last.send(attribute).length + 5 > 11
        max_lengths << sorted_by_attribute.last.send(attribute).length + 5
      else
        max_lengths << 11
      end
    end
    return max_lengths
  end

  def district
    if @results.length < 10
      @results.each do |attendee|
        url = "https://congress.api.sunlightfoundation.com/districts/locate?zip=#{attendee.zipcode}&apikey=d2feb7fe2971453889f66b544ee396c4"
        response = Net::HTTP.get_response(URI.parse(url))
        sunlight_data = JSON.parse(response.body)
        unless sunlight_data["results"].empty?
          attendee.district = sunlight_data["results"][0]["district"].to_s
        end
      end
    end
  end

  def print_by(attribute)
    @results.sort_by! do |attendee|
      attendee.send(attribute)
    end
    print
  end

  def save(filename)
    CSV.open("./output/#{filename}", "wb") do |csv|
      csv << ["last_name", "first_name", "email_address", "zipcode", "city", "state", "street", "homephone", "district"]
      @results.each do |attendee|
        row = [attendee.last_name, attendee.first_name, attendee.email, attendee.zipcode, attendee.city, attendee.state, attendee.address, attendee.phone, attendee.district]
        csv << row
      end
    end
  end

  def export(filename)
    data_report_template = File.read "data_report_template.erb"
    erb_template = ERB.new data_report_template
    data_report = erb_template.result(binding)
    File.open("./output/#{filename}",'w') do |file|
      file.puts data_report
    end
  end

end
