require "csv"

class EventData
  attr_reader :contents

  def load(file)
    @contents = CSV.open file,
      headers: true, header_converters: :symbol
  end

end
