require "csv"

class EventData
  attr_reader :results, :contents

  def load(file)
    @contents = CSV.read file,
      headers: true, header_converters: :symbol
    clean_contents
  end

  def clean_contents
    @contents.each do |row|
      row.each do |key, attribute|
        row[key] = attribute.to_s
        row[key] = attribute.to_s.rjust(5,"0")[0..4] if key == :zipcode
      end
    end
  end

  def find(attribute, criteria)
    @results = @contents.select do |row|
      row[attribute].upcase == criteria.upcase
    end
  end

end
