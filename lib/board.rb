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

    first_coordinate = coordinates.first.chars.last
    coordinate_same_nums = coordinates.all? do |coordinate|
      coordinate[1] == first_coordinate
    end

    first_letter = coordinates.first.chars.first
    coordinate_letters_boolean = coordinates.all? do |coordinate|
      coordinate[0] == first_letter
    end

    consecutive_letters = []
    ("A".ord.."D".ord).each_cons(ship.length) do |letter|
      consecutive_letters << letter
    end

    coordinate_letters = coordinates.map do |coordinate|
      coordinate.split('')[0].ord
    end

    if coordinate_letters_boolean == true
      coordinates.length == ship.length && consecutive_coordinates.any?{ |nums| nums == coordinate_nums}
    elsif coordinate_same_nums == true
      consecutive_letters.any? do |letter|
        letter == coordinate_letters
      end
    elsif coordinate_letters_boolean == false
      false
    end
  end
end
