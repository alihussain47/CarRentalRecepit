require 'json'

class Driver
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

  # Returns a statement in json
  def json_statement
    total = 0
    bonus_points = 0
    cars = []
    for r in @rentals
      this_amount = 0
      case r.car.style
      when Car::SUV
        this_amount += r.days_rented * 30
      when Car::HATCHBACK
        this_amount += 15
        this_amount += (r.days_rented - 3) * 15 if r.days_rented > 3
      when Car::SALOON
        this_amount += 20
        this_amount += (r.days_rented - 2) * 15 if r.days_rented > 2
      end
      bonus_points -= 10 if this_amount < 0
      bonus_points = bonus_points + 1
      bonus_points = bonus_points + 1 if r.car.style == Car::SUV && r.days_rented > 1
      cars << r.car.title.to_s + "," + this_amount.to_s
      total += this_amount
    end
    {
      cars: cars,
      owed: "Amount owed is €" + "#{total.to_s}",
      bonus: "Earned bonus points: " + bonus_points.to_s
    }.to_json
  end

  def statement
    total = 0
    bonus_points = 0
    result = "Car rental record for #{@name.to_s}\n"
    for r in @rentals
      this_amount = 0
      case r.car.style
      when Car::SUV
        this_amount += r.days_rented * 30
      when Car::HATCHBACK
        this_amount += 15
        this_amount += (r.days_rented - 3) * 15 if r.days_rented > 3
      when Car::SALOON
        this_amount += 20
        this_amount += (r.days_rented - 2) * 15 if r.days_rented > 2
      end
      bonus_points -= 10 if this_amount < 0
      bonus_points = bonus_points + 1
      bonus_points = bonus_points + 1 if r.car.style == Car::SUV && r.days_rented > 1
      result += r.car.title.to_s + "," + this_amount.to_s + "\n"
      total += this_amount
    end

    result += "Amount owed is €" + "#{total.to_s}" + "\n"
    result += "Earned bonus points: " + bonus_points.to_s
    result
  end
end