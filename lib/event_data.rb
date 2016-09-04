require "csv"

class EventData
  attr_reader :contents, :results

  def load(file)
    @contents = CSV.open file,
      headers: true, header_converters: :symbol

  end

  def find(name)
    @results = @contents.select do |row|
      row[:first_name].upcase == name.upcase
    end
  end

end
