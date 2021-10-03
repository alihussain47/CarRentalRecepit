class Car
  SALOON = 0
  SUV = 1
  HATCHBACK = 2

  attr_reader :title
  attr_accessor :style

  def initialize(title, style)
    @title = title
    @style = style
  end
end