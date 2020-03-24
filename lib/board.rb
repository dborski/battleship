class Board

  attr_reader :cells_hash
  def initialize
    @cells_hash = Hash.new
    @coordinates = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4",]
  end

  def cells
    @coordinates.each do |coordinate|
      cells_hash[coordinate] = Cell.new(coordinate)
    end
    cells_hash
  end

  def valid_coordinate?(coordinate)
    cells
    cells_hash[coordinate]&.coordinate == coordinate
  end

  def valid_placement?(ship, coordinates)
    consecutive_coordinates = []
    (1..4).each_cons(ship.length) do |nums|
      consecutive_coordinates << nums
    end

    coordinate_nums = coordinates.map do |coordinate|
      coordinate.split('')[1].to_i
    end

    coordinates.length == ship.length && consecutive_coordinates.any?{ |nums| nums == coordinate_nums}
  end
end
