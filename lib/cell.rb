class Cell

  attr_reader :coordinate
  attr_accessor :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
    @render_value = "."
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
      ship.hit
      @render_value = "H"
    else
      @render_value = "M"
    end
    @fired_upon = true
  end

  def render(ship_shown = false)
    if @ship != nil && ship_shown == true
      @render_value = "S"
    elsif ship != nil && ship.sunk?
      @render_value = "X"
    end
    @render_value
  end
end
