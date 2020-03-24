class Cell

  attr_reader :coordinate, :ship
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
      @render = "H"
    else
      @render = "M"
    end
    @fired_upon = true
  end

  def render(ship_shown = false)
    if @ship != nil && ship_shown == true
      @render = "S"
    end
    @render
  end



end
