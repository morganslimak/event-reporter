require 'net/http'
require 'json'
require 'erb'
require_relative 'printer'

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
    printer = Printer.new(@results, @attributes)
    max_lengths = printer.find_max_lengths
    return if max_lengths.empty?
    printer.print_headers(max_lengths)
    printer.print_attributes(max_lengths)
  end

  def print_by(attribute)
    @results.sort_by! do |attendee|
      attendee.send(attribute)
    end
    print
  end

  def district
    if @results.length < 10
      @results.each do |attendee|
        url = "https://congress.api.sunlightfoundation.com/districts/locate?"\
          "zip=#{attendee.zipcode}&apikey=d2feb7fe2971453889f66b544ee396c4"
        response = Net::HTTP.get_response(URI.parse(url))
        sunlight_data = JSON.parse(response.body)
        unless sunlight_data["results"].empty?
          attendee.district = sunlight_data["results"][0]["district"].to_s
        end
      end
    end
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
