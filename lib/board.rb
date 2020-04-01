class Board

  attr_reader :cells, :coordinates
  def initialize
    @cells = Hash.new
    @coordinates = []
    generate_coordinates
    generate_cells
  end

  def generate_cells
    @coordinates.each do |coordinate|
      cells[coordinate] = Cell.new(coordinate)
    end
  end

  def generate_coordinates(size = 12)
    nums_array = create_array_of_nums(size)
    @coordinates = nums_array.each_with_index.map do |nums, index|
      nums.map{ |num| (index.ord + 65).chr + num}
    end.flatten
  end

  def create_array_of_nums(size)
    nums_array = []
    size.times { nums_array << (1..size).to_a }
    nums_array.map{ |nums| nums.map{ |num| num.to_s } }
  end

  def valid_coordinate?(coordinate)
    cells[coordinate]&.coordinate == coordinate
  end

  def consecutive_nums_by_length(ship, coordinates)
    consecutive_coordinates = []
    board_width = Math.sqrt(@coordinates.length)
    (1..board_width).each_cons(ship.length) do |nums|
      consecutive_coordinates << nums
    end
    consecutive_coordinates
  end

  def consecutive_letters_by_length(ship, coordinates)
    consecutive_letters_sorted = []
    board_height = Math.sqrt(@coordinates.length) + 64
    ("A".ord..board_height).each_cons(ship.length) do |letter|
      consecutive_letters_sorted << letter
    end
    consecutive_letters_sorted
  end

  def check_coordinates_same_nums(ship, coordinates)
    first_coordinate = coordinates.first.chars[-1..1].join
    coordinate_same_nums = coordinates.all? do |coordinate|
      coordinate.chars[-1..1].join == first_coordinate
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
      coordinate.chars[1..-1].join.to_i
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

  def each_coordinate_letter
    coordinates.map do |coordinate|
      coordinate[0]
    end.uniq
  end

  def first_line
    size = Math.sqrt(@coordinates.length)
    first_line = " "
    (1..size).each do |num|
      first_line.concat(" #{num.to_s}")
    end
    first_line.concat("\n")
  end

  def render(ship_shown = false)
    lines = [first_line]
    each_coordinate_letter.each do |letter|
      new_line = "#{letter}\n"
      cells.each do |coordinate, cell|
        if coordinate[0] == letter
          new_line.gsub!(("\n"), (" " + cell.render(ship_shown) + "\n"))
        end
      end
      lines << new_line
    end
    lines.join("")
  end
end
