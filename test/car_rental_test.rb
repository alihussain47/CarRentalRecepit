# frozen_string_literal: true
require 'test_helper'
require 'byebug'

class SeatsGeneratorTest < Minitest::Test
  def setup
    @saloon1 = Car.new('Audi A3', Car::SALOON)
    @suv1 = Car.new('BMW X1', Car::SUV)
    @driver = Driver.new('Bill Simpson')
  end

  def test_if_cars_listed_in_statement
    @driver.add_rental(Rental.new(@suv1, 2)) # rent this SUV for 2 days
    @driver.add_rental(Rental.new(@saloon1, 2))
    statement = @driver.statement
    puts statement
    assert_equal(statement.include?('BMW'), true)
    assert_equal(statement.include?('Audi'), true)
  end

  def test_only_one_cars_listed_in_statement
    @driver.add_rental(Rental.new(@suv1, 2))
    statement = @driver.json_statement
    puts statement
    assert_equal(JSON.parse(statement)["cars"].count, 1)
  end
end
