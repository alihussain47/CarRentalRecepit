class Rental
  attr_reader :car, :days_rented

  def initialize(car, days_rented)
    @car = car
    @days_rented = days_rented

    if !(@days_rented > 0)
      raise 'Error: days_rented invalid'
    end
  end
end