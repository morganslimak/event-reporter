class Attendee
  attr_reader :last_name, :first_name, :email, :zipcode, :city, :state, :address, :phone
  attr_accessor :district
  
  def initialize(row)
    @last_name = row[:last_name]
    @first_name = row[:first_name]
    @email = row[:email_address]
    @zipcode = row[:zipcode]
    @city = row[:city]
    @state = row[:state]
    @address = row[:street]
    @phone = row[:homephone]
    @district = ""
  end
end
