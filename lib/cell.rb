class Cell

  attr_reader :coordinate, :ship, :render
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
    @render = "."
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if empty? == false
      ship.health -= 1
    else
      @render = "M"
    end
    @fired_upon = true
  end



end
