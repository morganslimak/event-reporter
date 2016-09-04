require "csv"

class EventData

  def load(file)
    @contents = CSV.open 'file',
      headers: true, header_converters: :symbol
  end

end
