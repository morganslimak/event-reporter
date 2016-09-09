class Printer
  def initialize(results, attributes)
    @results = results
    @attributes = attributes
    @headers = ["LAST NAME", "FIRST NAME", "EMAIL", "ZIPCODE", "CITY",
               "STATE", "ADDRESS", "PHONE", "DISTRICT"]
  end

  def find_max_lengths
    max_lengths = []
    @attributes.each do |attribute|
      break if @results.empty?
      attributes_by_length = sort_attributes_by_length(attribute)
      max_length = attributes_by_length.last.send(attribute).length + 5
      max_length > 11 ? max_lengths << max_length : max_lengths << 11
    end
    return max_lengths
  end

  def sort_attributes_by_length(attribute)
    @results.sort_by do |attendee|
      attendee.send(attribute).length
    end
  end

  def print_headers(max_lengths)
    headers_and_lengths = @headers.zip(max_lengths)
    formatted_headers = ""
    headers_and_lengths.each do |header, length|
      formatted_headers += header.ljust(length)
    end
    puts formatted_headers
  end

  def print_attributes(max_lengths)
    attributes_and_lengths = @attributes.zip(max_lengths)
    @results.each do |attendee|
      print_attendee(attributes_and_lengths, attendee)
    end
  end

  def print_attendee(attributes_and_lengths, attendee)
    formatted_attributes = ""
    attributes_and_lengths.each do |attribute, length|
      formatted_attributes += attendee.send(attribute).ljust(length)
    end
    puts formatted_attributes
  end
end
