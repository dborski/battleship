class Board

  attr_reader :cells
  def initialize
    @cells = Hash.new
    @coordinates = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4",]
    generate_cells
  end

  def generate_cells
    @coordinates.each do |coordinate|
      cells[coordinate] = Cell.new(coordinate)
    end
  end

  def valid_coordinate?(coordinate)
    cells[coordinate]&.coordinate == coordinate
  end

  def consecutive_nums_by_length(ship, coordinates)
    consecutive_coordinates = []
    (1..4).each_cons(ship.length) do |nums|
      consecutive_coordinates << nums
    end
    consecutive_coordinates
  end

  def consecutive_letters_by_length(ship, coordinates)
    consecutive_letters_sorted = []
    ("A".ord.."D".ord).each_cons(ship.length) do |letter|
      consecutive_letters_sorted << letter
    end
    consecutive_letters_sorted
  end

  def check_coordinates_same_nums(ship, coordinates)
    first_coordinate = coordinates.first.chars.last
    coordinate_same_nums = coordinates.all? do |coordinate|
      coordinate[1] == first_coordinate
    end
    coordinate_same_nums
  end

  def check_coordinates_same_letters(ship, coordinates)
    first_letter = coordinates.first.chars.first
    coordinate_letters = coordinates.all? do |coordinate|
      coordinate[0] == first_letter
    end
    coordinate_letters
  end

  def coordinate_nums(ship, coordinates)
    coordinates.map do |coordinate|
        coordinate.split('')[1].to_i
    end
  end

  def coordinate_letters(ship, coordinates)
    coordinates.map do |coordinate|
      coordinate.split('')[0].ord
    end
  end

  def nums_same_as_length(ship, coordinates)
    consecutive_nums_by_length(ship, coordinates).any? do |nums|
     nums == coordinate_nums(ship, coordinates)
    end
  end

  def letters_same_as_length(ship, coordinates)
    consecutive_letters_by_length(ship, coordinates).any? do |letter|
      letter == coordinate_letters(ship, coordinates)
    end
  end

  def ship_on_any_coordinate(coordinates)
    coordinates.any? do |coordinate|
      cells[coordinate].ship
    end
  end

  def check_all_valid_coordinates(ship, coordinates)
    coordinates.all? { |coordinate| valid_coordinate?(coordinate)}
  end

  def valid_placement?(ship, coordinates)
    if check_all_valid_coordinates(ship, coordinates) && ship_on_any_coordinate(coordinates) == false
      if check_coordinates_same_letters(ship, coordinates) == true
         coordinates.length == ship.length && nums_same_as_length(ship, coordinates)
      elsif check_coordinates_same_nums(ship, coordinates) == true
         letters_same_as_length(ship, coordinates)
      elsif check_coordinates_same_letters(ship, coordinates) == false
         false
      end
    else
      false
    end
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      cells[coordinate].place_ship(ship)
    end
  end

  def render(ship_shown = false)
    a_line = "A\n"
    b_line = "B\n"
    c_line = "C\n"
    d_line = "D\n"

    cells.each do |coordinate, cell|
      if coordinate.chars.first == "A"
         a_line.gsub!("\n", (" " + cell.render(ship_shown) + "\n"))
      elsif coordinate.chars.first == "B"
        b_line.gsub!("\n", (" " + cell.render(ship_shown) + "\n"))
      elsif coordinate.chars.first == "C"
        c_line.gsub!("\n", (" " + cell.render(ship_shown) + "\n"))
      elsif coordinate.chars.first == "D"
        d_line.gsub!("\n", (" " + cell.render(ship_shown) + "\n"))
      end
    end

     rendered =
     ("  1 2 3 4 \n" +
      a_line +
      b_line +
      c_line +
      d_line)

      rendered
  end
end
