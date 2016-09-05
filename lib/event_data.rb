require "csv"

class EventData
  attr_reader :results, :contents

  def load(file)
    @contents = CSV.read file,
      headers: true, header_converters: :symbol
  end

  def find(attribute, criteria)
    @results = @contents.select do |row|
      row[attribute].to_s.upcase == criteria.upcase
    end
  end

  def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
  end

end
