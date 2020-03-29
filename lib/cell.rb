class Cell

  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
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
    ship.hit if empty? == false
    @fired_upon = true
  end

  def render(ship_shown = false)
    if ship != nil && ship.sunk?
      "X"
    elsif ship != nil && @fired_upon == true
      "H"
    elsif ship != nil && ship_shown == true
      "S"
    elsif ship == nil && @fired_upon == true
      "M"
    else
      "."
    end
  end
end
